create sequence inode_seq;
create table if not exists metadata (
    inode bigint unique not null default nextval('inode_seq'),

    uid   bigint not null,
    gid   bigint not null,

    mode  bigint not null,
    type  bigint not null,

    ctime bigint not null,
    atime bigint not null,
    mtime bigint not null,

    name  text    not null,
    size  bigint not null default 0
);
alter sequence inode_seq owned by metadata.inode;

create table if not exists filedata (
    inode  bigint unique not null,
    data   bytea  default null,

    foreign key(inode) references metadata(inode) on delete cascade
);

create table if not exists parent (
    pinode bigint not null,
    inode  bigint not null,

    unique (pinode, inode),

    foreign key(inode) references metadata(inode) on delete cascade,
    foreign key(pinode) references metadata(inode) on delete cascade
);
