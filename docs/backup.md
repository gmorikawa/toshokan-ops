# Backup

The backup of this system consist of two parts:

1. Make a dump of the current state of the database's data.
2. Copy the application files from bind mount of _server_ container (this is in case file storage is the host machine, and not an external service like AWS's S3).

This project uses _postgres_, so the process may differ using another DBMS. Regardless, all of them might have a `dump` command to take all the data from the database.

## Postgres Dump

To execute a dump in a database running in a container execute the following:

```sh
docker exec <container_name> pg_dump -U <db_user> <db_name> > <dumpfile>.sql
```

After executing it you should have the `<dumpfile>.sql` in the current directory.

## Compressing files

In this case I am compressing the files from the bind mount with `tar`. First I navigate to the `server`'s bind mounted directory and then execute:

```sh
tar -czvf toshokan-files.tar.gz books researchpapers whitepapers
```

This command will compress all those directories and then create a file called `toshokan-files.tar.gz`.

## SSH: Transfering the backup files

In my case, I am using a virtual machine to run the dockerized system. Using only `ssh` is possible from the host machine to copy files from the virtual machine using the command `scp`. By using the following command template you can easily copy dump and compressed files to your machine.

```sh
scp username@hostname:/path/to/remote/file /path/to/local/destination
```

## References

* [Bind mounts | Docker Docs](https://docs.docker.com/engine/storage/bind-mounts/), accessed on 2026-02-12;
* [scp(1): secure copy - Linux man page](https://linux.die.net/man/1/scp), accessed on 2026-02-12;