PRAGMA foreign_keys = O;
attach database '/mnt/pmem0/backup_tpcc/tpcc.0.db_backup' as backup0;
attach database '/mnt/pmem0/backup_tpcc/tpcc.1.db_backup' as backup1;
attach database '/mnt/pmem0/backup_tpcc/tpcc.2.db_backup' as backup2;
attach database '/mnt/pmem0/backup_tpcc/tpcc.3.db_backup' as backup3;
attach database '/mnt/pmem0/backup_tpcc/tpcc.4.db_backup' as backup4;
attach database '/mnt/pmem0/backup_tpcc/tpcc.5.db_backup' as backup5;
attach database '/mnt/pmem0/backup_tpcc/tpcc.6.db_backup' as backup6;
attach database '/mnt/pmem0/backup_tpcc/tpcc.7.db_backup' as backup7;
attach database '/mnt/pmem0/backup_tpcc/tpcc.8.db_backup' as backup8;
attach database '/home/mania/tpcc_w_640/tpcc.9.db_backup' as backup9;


drop table if exists warehouse;

create table backup7.warehouse (
w_id smallint not null,
w_name varchar(10), 
w_street_1 varchar(20), 
w_street_2 varchar(20), 
w_city varchar(20), 
w_state char(2), 
w_zip char(9), 
w_tax decimal(4,2), 
w_ytd decimal(12,2),
PRIMARY KEY(w_id) );

drop table if exists district;

create table backup6.district (
d_id tinyint not null, 
d_w_id smallint not null, 
d_name varchar(10), 
d_street_1 varchar(20), 
d_street_2 varchar(20), 
d_city varchar(20), 
d_state char(2), 
d_zip char(9), 
d_tax decimal(4,2), 
d_ytd decimal(12,2), 
d_next_o_id int,
PRIMARY KEY(d_id, d_w_id),
FOREIGN KEY(d_w_id) REFERENCES warehouse(w_id));

drop table if exists customer;

create table backup3.customer (
c_id int not null, 
c_d_id tinyint not null,
c_w_id smallint not null, 
c_first varchar(16), 
c_middle char(2), 
c_last varchar(16), 
c_street_1 varchar(20), 
c_street_2 varchar(20), 
c_city varchar(20), 
c_state char(2), 
c_zip char(9), 
c_phone char(16), 
c_since datetime, 
c_credit char(2), 
c_credit_lim bigint, 
c_discount decimal(4,2), 
c_balance decimal(12,2), 
c_ytd_payment decimal(12,2), 
c_payment_cnt smallint, 
c_delivery_cnt smallint, 
c_data text,
PRIMARY KEY(c_id, c_d_id, c_w_id),
FOREIGN KEY(c_d_id, c_w_id) REFERENCES district(d_id, d_w_id));

drop table if exists history;

create table backup8.history (
h_c_id int, 
h_c_d_id tinyint, 
h_c_w_id smallint,
h_d_id tinyint,
h_w_id smallint,
h_date datetime,
h_amount decimal(6,2), 
h_data varchar(24),
FOREIGN KEY(h_c_id, h_c_d_id, h_c_w_id) REFERENCES customer(c_id, c_d_id, c_w_id),
FOREIGN KEY(h_d_id, h_w_id) REFERENCES district(d_id, d_w_id));

drop table if exists orders;

create table backup2.orders (
o_id int not null, 
o_d_id tinyint not null, 
o_w_id smallint not null,
o_c_id int,
o_entry_d datetime,
o_carrier_id tinyint,
o_ol_cnt tinyint, 
o_all_local tinyint,
PRIMARY KEY(o_id, o_d_id, o_w_id),
FOREIGN KEY(o_c_id, o_d_id, o_w_id) REFERENCES customer(c_id, c_d_id, c_w_id));

drop table if exists new_orders;

create table backup4.new_orders (
no_o_id int not null,
no_d_id tinyint not null,
no_w_id smallint not null,
PRIMARY KEY(no_o_id, no_d_id, no_w_id),
FOREIGN KEY(no_o_id, no_d_id, no_w_id) REFERENCES orders(o_id, o_d_id, o_w_id));

drop table if exists order_line;

create table backup0.order_line ( 
ol_o_id int not null, 
ol_d_id tinyint not null,
ol_w_id smallint not null,
ol_number tinyint not null,
ol_i_id int, 
ol_supply_w_id smallint,
ol_delivery_d datetime, 
ol_quantity tinyint, 
ol_amount decimal(6,2), 
ol_dist_info char(24),
PRIMARY KEY(ol_o_id, ol_d_id, ol_w_id, ol_number),
FOREIGN KEY(ol_o_id, ol_d_id, ol_w_id) REFERENCES orders(o_id, o_d_id, o_w_id),
FOREIGN KEY(ol_i_id, ol_supply_w_id) REFERENCES stock(s_i_id, s_w_id));

drop table if exists item;

create table backup5.item (
i_id int not null, 
i_im_id int, 
i_name varchar(24), 
i_price decimal(5,2), 
i_data varchar(50),
PRIMARY KEY(i_id));

drop table if exists stock;

create table backup1.stock (
s_i_id int not null, 
s_w_id smallint not null, 
s_quantity smallint, 
s_dist_01 char(24), 
s_dist_02 char(24),
s_dist_03 char(24),
s_dist_04 char(24), 
s_dist_05 char(24), 
s_dist_06 char(24), 
s_dist_07 char(24), 
s_dist_08 char(24), 
s_dist_09 char(24), 
s_dist_10 char(24), 
s_ytd decimal(8,0), 
s_order_cnt smallint, 
s_remote_cnt smallint,
s_data varchar(50),
PRIMARY KEY(s_i_id,s_w_id),
FOREIGN KEY(s_w_id) REFERENCES warehouse(w_id),
FOREIGN KEY(s_i_id) REFERENCES item(i_id));

CREATE INDEX backup3.idx_customer ON customer (c_w_id, c_d_id, c_last, c_first);
CREATE INDEX backup2.idx_orders ON orders (o_w_id, o_d_id, o_c_id, o_id);

PRAGMA foreign_keys = ON;
