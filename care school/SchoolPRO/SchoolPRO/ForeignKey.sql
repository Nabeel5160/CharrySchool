Alter table tbl_Users add CONSTRAINT [FK_Designation] Foreign Key (nDesig_id) references tbl_Designation(nDesg_id);


Alter table tbl_Users Drop column nDesg_id;