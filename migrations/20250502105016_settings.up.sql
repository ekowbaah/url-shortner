-- Add up migration script here
create table if not exists settings
(
    id                       text default 'DEFAULT_SETTINGS' not null primary key,
    encrypted_global_api_key text                            not null
);

insert into settings (encrypted_global_api_key)
values ('7a6674be390b0a4e6c413a84fa95438be4b8e1c1206f1ce46cd7e8e247666af8');
