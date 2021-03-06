+++
date = "2017-06-10T21:11:25-04:00"
description = "default initialization log"
title = "default_init.log"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "init"
    parent = "code"
    weight = 1

+++

Result of running `docker logs adoring_lamport`.


```console
$ docker logs adoring_lamport
usermod: no changes
usermod: no changes
Starting MySQL.170610 16:56:36 mysqld_safe Logging to '/var/lib/mysql/a9890f386ece.err'.
170610 16:56:36 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
 SUCCESS!
exec mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
stty: standard input: Inappropriate ioctl for device
stty: standard input: Inappropriate ioctl for device
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] New password:
Re-enter new password:
stty: standard input: Inappropriate ioctl for device
stty: standard input: Inappropriate ioctl for device
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n]  ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n]  ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n]  - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n]  ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
Grants for irods@localhost
GRANT USAGE ON *.* TO 'irods'@'localhost' IDENTIFIED BY PASSWORD '*60E38376E2C974797971A03D9BEEF1F5EB169FEA'
GRANT ALL PRIVILEGES ON `ICAT`.* TO 'irods'@'localhost'
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking build system type... x86_64-unknown-linux-gnu
checking host system type... x86_64-unknown-linux-gnu
checking how to print strings... printf
checking for style of include used by make... GNU
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking for a sed that does not truncate output... /usr/bin/sed
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for fgrep... /usr/bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking how to convert x86_64-unknown-linux-gnu file names to x86_64-unknown-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-unknown-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... dlltool
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for mt... no
checking if : is a manifest tool... no
./configure: line 6607: /usr/bin/file: No such file or directory
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... no
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for gcc... (cached) gcc
ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
which: no mysqltest in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
dirname: missing operand
Try 'dirname --help' for more information.
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking dependency style of gcc... (cached) gcc3
checking for mysqlbin... checking for mysql_config... /usr/bin/mysql_config
checking for MySQL libraries... yes
configure: setting libdir to mysql plugin dir /usr/lib64/mysql/plugin
checking for pcre-config... /usr/bin/pcre-config
checking for PCRE - version >= 1... 8.32
checking for the pthreads library -lpthread... yes
checking for joinable pthread attribute... PTHREAD_CREATE_JOINABLE
checking if more special flags are required for pthreads... no
checking for PTHREAD_PRIO_INHERIT... yes
checking for pthread_attr_setstacksize... yes
checking for pthread_attr_get_np... no
checking for pthread_getattr_np... yes
checking for pthread_getattr_np declaration... missing
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating test/Makefile
config.status: creating doc/Makefile
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands
(CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /lib_mysqludf_preg/config/missing autoheader)
rm -f stamp-h1
touch config.h.in
cd . && /bin/sh ./config.status config.h
config.status: creating config.h
config.status: config.h is unchanged
make  all-recursive
make[1]: Entering directory `/lib_mysqludf_preg'
Making all in test
make[2]: Entering directory `/lib_mysqludf_preg/test'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/lib_mysqludf_preg/test'
Making all in doc
make[2]: Entering directory `/lib_mysqludf_preg/doc'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/lib_mysqludf_preg/doc'
make[2]: Entering directory `/lib_mysqludf_preg'
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-preg.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg.Tpo -c -o lib_mysqludf_preg_la-preg.lo `test -f 'preg.c' || echo './'`preg.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg.Tpo -c preg.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-preg.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg.Tpo -c preg.c -o lib_mysqludf_preg_la-preg.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-preg.Tpo .deps/lib_mysqludf_preg_la-preg.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-preg_utils.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg_utils.Tpo -c -o lib_mysqludf_preg_la-preg_utils.lo `test -f 'preg_utils.c' || echo './'`preg_utils.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg_utils.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg_utils.Tpo -c preg_utils.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-preg_utils.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg_utils.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg_utils.Tpo -c preg_utils.c -o lib_mysqludf_preg_la-preg_utils.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-preg_utils.Tpo .deps/lib_mysqludf_preg_la-preg_utils.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-ghmysql.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghmysql.Tpo -c -o lib_mysqludf_preg_la-ghmysql.lo `test -f 'ghmysql.c' || echo './'`ghmysql.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghmysql.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghmysql.Tpo -c ghmysql.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-ghmysql.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghmysql.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghmysql.Tpo -c ghmysql.c -o lib_mysqludf_preg_la-ghmysql.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-ghmysql.Tpo .deps/lib_mysqludf_preg_la-ghmysql.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-ghfcns.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghfcns.Tpo -c -o lib_mysqludf_preg_la-ghfcns.lo `test -f 'ghfcns.c' || echo './'`ghfcns.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghfcns.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghfcns.Tpo -c ghfcns.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-ghfcns.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghfcns.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghfcns.Tpo -c ghfcns.c -o lib_mysqludf_preg_la-ghfcns.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-ghfcns.Tpo .deps/lib_mysqludf_preg_la-ghfcns.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-from_php.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-from_php.Tpo -c -o lib_mysqludf_preg_la-from_php.lo `test -f 'from_php.c' || echo './'`from_php.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-from_php.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-from_php.Tpo -c from_php.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-from_php.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-from_php.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-from_php.Tpo -c from_php.c -o lib_mysqludf_preg_la-from_php.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-from_php.Tpo .deps/lib_mysqludf_preg_la-from_php.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo `test -f 'lib_mysqludf_preg_capture.c' || echo './'`lib_mysqludf_preg_capture.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo -c lib_mysqludf_preg_capture.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo -c lib_mysqludf_preg_capture.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo `test -f 'lib_mysqludf_preg_check.c' || echo './'`lib_mysqludf_preg_check.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo -c lib_mysqludf_preg_check.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_check.o
lib_mysqludf_preg_check.c: In function ‘preg_check’:
lib_mysqludf_preg_check.c:174:9: warning: return makes integer from pointer without a cast [enabled by default]
         return NULL ;
         ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo -c lib_mysqludf_preg_check.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_check.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo `test -f 'lib_mysqludf_preg_info.c' || echo './'`lib_mysqludf_preg_info.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo -c lib_mysqludf_preg_info.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_info.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo -c lib_mysqludf_preg_info.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_info.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo `test -f 'lib_mysqludf_preg_position.c' || echo './'`lib_mysqludf_preg_position.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo -c lib_mysqludf_preg_position.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_position.o
lib_mysqludf_preg_position.c: In function ‘preg_position’:
lib_mysqludf_preg_position.c:218:9: warning: return makes integer from pointer without a cast [enabled by default]
         return NULL ;
         ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo -c lib_mysqludf_preg_position.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_position.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo `test -f 'lib_mysqludf_preg_replace.c' || echo './'`lib_mysqludf_preg_replace.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo -c lib_mysqludf_preg_replace.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o
lib_mysqludf_preg_replace.c: In function ‘preg_replace’:
lib_mysqludf_preg_replace.c:298:26: warning: comparison between pointer and integer [enabled by default]
         if (!s && msg[0] != NULL) {
                          ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo -c lib_mysqludf_preg_replace.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo `test -f 'lib_mysqludf_preg_rlike.c' || echo './'`lib_mysqludf_preg_rlike.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo -c lib_mysqludf_preg_rlike.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o
lib_mysqludf_preg_rlike.c: In function ‘preg_rlike’:
lib_mysqludf_preg_rlike.c:179:13: warning: return makes integer from pointer without a cast [enabled by default]
             return NULL ;
             ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo -c lib_mysqludf_preg_rlike.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Plo
/bin/sh ./libtool  --tag=CC   --mode=link gcc -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -module -avoid-version -lpcre -lpthread  -o lib_mysqludf_preg.la -rpath /usr/lib64/mysql/plugin lib_mysqludf_preg_la-preg.lo lib_mysqludf_preg_la-preg_utils.lo lib_mysqludf_preg_la-ghmysql.lo lib_mysqludf_preg_la-ghfcns.lo lib_mysqludf_preg_la-from_php.lo lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo
libtool: link: gcc -shared  -fPIC -DPIC  .libs/lib_mysqludf_preg_la-preg.o .libs/lib_mysqludf_preg_la-preg_utils.o .libs/lib_mysqludf_preg_la-ghmysql.o .libs/lib_mysqludf_preg_la-ghfcns.o .libs/lib_mysqludf_preg_la-from_php.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_check.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_info.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_position.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o   -lpcre -lpthread  -O2   -Wl,-soname -Wl,lib_mysqludf_preg.so -o .libs/lib_mysqludf_preg.so
libtool: link: ar cru .libs/lib_mysqludf_preg.a  lib_mysqludf_preg_la-preg.o lib_mysqludf_preg_la-preg_utils.o lib_mysqludf_preg_la-ghmysql.o lib_mysqludf_preg_la-ghfcns.o lib_mysqludf_preg_la-from_php.o lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o lib_mysqludf_preg_la-lib_mysqludf_preg_check.o lib_mysqludf_preg_la-lib_mysqludf_preg_info.o lib_mysqludf_preg_la-lib_mysqludf_preg_position.o lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o
libtool: link: ranlib .libs/lib_mysqludf_preg.a
libtool: link: ( cd ".libs" && rm -f "lib_mysqludf_preg.la" && ln -s "../lib_mysqludf_preg.la" "lib_mysqludf_preg.la" )
make[2]: Leaving directory `/lib_mysqludf_preg'
make[1]: Leaving directory `/lib_mysqludf_preg'
Making install in test
make[1]: Entering directory `/lib_mysqludf_preg/test'
make[2]: Entering directory `/lib_mysqludf_preg'
make[2]: Leaving directory `/lib_mysqludf_preg'
make[2]: Entering directory `/lib_mysqludf_preg/test'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/lib_mysqludf_preg/test'
make[1]: Leaving directory `/lib_mysqludf_preg/test'
Making install in doc
make[1]: Entering directory `/lib_mysqludf_preg/doc'
make[2]: Entering directory `/lib_mysqludf_preg'
make[2]: Leaving directory `/lib_mysqludf_preg'
make[2]: Entering directory `/lib_mysqludf_preg/doc'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/lib_mysqludf_preg/doc'
make[1]: Leaving directory `/lib_mysqludf_preg/doc'
make[1]: Entering directory `/lib_mysqludf_preg'
make[2]: Entering directory `/lib_mysqludf_preg'
 /usr/bin/mkdir -p '/usr/lib64/mysql/plugin'
 /bin/sh ./libtool   --mode=install /usr/bin/install -c   lib_mysqludf_preg.la '/usr/lib64/mysql/plugin'
libtool: install: /usr/bin/install -c .libs/lib_mysqludf_preg.so /usr/lib64/mysql/plugin/lib_mysqludf_preg.so
libtool: install: /usr/bin/install -c .libs/lib_mysqludf_preg.lai /usr/lib64/mysql/plugin/lib_mysqludf_preg.la
libtool: install: /usr/bin/install -c .libs/lib_mysqludf_preg.a /usr/lib64/mysql/plugin/lib_mysqludf_preg.a
libtool: install: chmod 644 /usr/lib64/mysql/plugin/lib_mysqludf_preg.a
libtool: install: ranlib /usr/lib64/mysql/plugin/lib_mysqludf_preg.a
libtool: finish: PATH="/sbin:/bin:/usr/sbin:/usr/bin:/sbin" ldconfig -n /usr/lib64/mysql/plugin
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/lib64/mysql/plugin

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the `LD_RUN_PATH' environment variable
     during linking
   - use the `-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to `/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/lib_mysqludf_preg'
make[1]: Leaving directory `/lib_mysqludf_preg'
/
Shutting down MySQL... SUCCESS!
Starting MySQL.170610 16:56:44 mysqld_safe Logging to '/var/lib/mysql/a9890f386ece.err'.
170610 16:56:44 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
 SUCCESS!
Warning: Hostname `a9890f386ece` should be a fully qualified domain name.
Updating /var/lib/irods/VERSION.json...
The iRODS service account name needs to be defined.
iRODS user [irods]:
iRODS group [irods]:

+--------------------------------+
| Setting up the service account |
+--------------------------------+

Existing Group Detected: irods
Existing Account Detected: irods
Setting owner of /var/lib/irods to irods:irods
Setting owner of /etc/irods to irods:irods
iRODS server's role:
1. provider
2. consumer
Please select a number or choose 0 to enter a new value [1]:
Updating /etc/irods/server_config.json...
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.

+-----------------------------------------+
| Configuring the database communications |
+-----------------------------------------+

You are configuring an iRODS database plugin. The iRODS server cannot be started until its database has been properly configured.

ODBC driver for mysql:
1. MySQL
2. MySQL ODBC 5.3 Unicode Driver
3. MySQL ODBC 5.3 ANSI Driver
Please select a number or choose 0 to enter a new value [1]:
Database server's hostname or IP address [localhost]:
Database server's port [3306]:
Database name [ICAT]:
Database username [irods]:

-------------------------------------------
Database Type: mysql
ODBC Driver:   MySQL ODBC 5.3 Unicode Driver
Database Host: localhost
Database Port: 3306
Database Name: ICAT
Database User: irods
-------------------------------------------

Please confirm [yes]:

Updating /etc/irods/server_config.json...
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Listing database tables...

Updating /etc/irods/server_config.json...

+--------------------------------+
| Configuring the server options |
+--------------------------------+

iRODS server's zone name [tempZone]:
iRODS server's port [1247]:
iRODS port range (begin) [20000]:
iRODS port range (end) [20199]:
Control Plane port [1248]:
Schema Validation Base URI (or off) [file:///var/lib/irods/configuration_schemas]:
iRODS server's administrator username [rods]:

-------------------------------------------
Zone name:                  tempZone
iRODS server port:          1247
iRODS port range (begin):   20000
iRODS port range (end):     20199
Control plane port:         1248
Schema validation base URI: file:///var/lib/irods/configuration_schemas
iRODS server administrator: rods
-------------------------------------------

Please confirm [yes]:



Updating /etc/irods/server_config.json...

+-----------------------------------+
| Setting up the client environment |
+-----------------------------------+




Updating /var/lib/irods/.irods/irods_environment.json...

+--------------------------+
| Setting up default vault |
+--------------------------+

iRODS Vault directory [/var/lib/irods/Vault]:

+-------------------------+
| Setting up the database |
+-------------------------+

Listing database tables...
Defining mysql functions...
Creating database tables...

+-------------------+
| Starting iRODS... |
+-------------------+

Validating [/var/lib/irods/.irods/irods_environment.json]... Success
Validating [/var/lib/irods/VERSION.json]... Success
Validating [/etc/irods/server_config.json]... Success
Validating [/etc/irods/host_access_control_config.json]... Success
Validating [/etc/irods/hosts_config.json]... Success
Ensuring catalog schema is up-to-date...
Updating to schema version 2...
Updating to schema version 3...
Updating to schema version 4...
Updating to schema version 5...
Catalog schema is up-to-date.
Starting iRODS server...
Success

+---------------------+
| Attempting test put |
+---------------------+

Putting the test file into iRODS...
Getting the test file from iRODS...
Removing the test file from iRODS...
Success.

+--------------------------------+
| iRODS is installed and running |
+--------------------------------+

Shutting down MySQL.. SUCCESS!
set /etc/my.cnf.d/server.cnf
$ cat /etc/my.cnf.d/server.cnf
[galera]
# Mandatory settings
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
wsrep_cluster_address=gcomm://
wsrep_cluster_name=galera
wsrep_node_address=localhost
wsrep_node_name=galera1
wsrep_sst_method=rsync

binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0
Starting MySQL.170610 16:56:49 mysqld_safe Logging to '/var/lib/mysql/a9890f386ece.err'.
170610 16:56:50 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
. SUCCESS!
[MySQL]> SHOW VARIABLES LIKE 'wsrep%';
Variable_name	Value
wsrep_osu_method	TOI
wsrep_auto_increment_control	ON
wsrep_causal_reads	OFF
wsrep_certify_nonpk	ON
wsrep_cluster_address	gcomm://
wsrep_cluster_name	galera
wsrep_convert_lock_to_trx	OFF
wsrep_data_home_dir	/var/lib/mysql/
wsrep_dbug_option
wsrep_debug	OFF
wsrep_desync	OFF
wsrep_dirty_reads	OFF
wsrep_drupal_282555_workaround	OFF
wsrep_forced_binlog_format	NONE
wsrep_gtid_domain_id	0
wsrep_gtid_mode	OFF
wsrep_load_data_splitting	ON
wsrep_log_conflicts	OFF
wsrep_max_ws_rows	0
wsrep_max_ws_size	2147483647
wsrep_mysql_replication_bundle	0
wsrep_node_address	localhost
wsrep_node_incoming_address	AUTO
wsrep_node_name	galera1
wsrep_notify_cmd
wsrep_on	ON
wsrep_patch_version	wsrep_25.19
wsrep_provider	/usr/lib64/galera/libgalera_smm.so
wsrep_provider_options	base_dir = /var/lib/mysql/; base_host = localhost;
base_port = 4567; cert.log_conflicts = no; debug = no; evs.auto_evict = 0;
evs.causal_keepalive_period = PT1S; evs.debug_log_mask = 0x1; evs.delay_margin
= PT1S; evs.delayed_keep_period = PT30S; evs.inactive_check_period = PT0.5S;
evs.inactive_timeout = PT15S; evs.info_log_mask = 0; evs.install_timeout =
PT7.5S; evs.join_retrans_period = PT1S; evs.keepalive_period = PT1S;
evs.max_install_timeouts = 3; evs.send_window = 4; evs.stats_report_period =
PT1M; evs.suspect_timeout = PT5S; evs.use_aggregate = true;
evs.user_send_window = 2; evs.version = 0; evs.view_forget_timeout = P1D;
gcache.dir = /var/lib/mysql/; gcache.keep_pages_size = 0; gcache.mem_size = 0;
gcache.name = /var/lib/mysql//galera.cache; gcache.page_size = 128M;
gcache.recover = no; gcache.size = 128M; gcomm.thread_prio = ; gcs.fc_debug =
0; gcs.fc_factor = 1.0; gcs.fc_limit = 16; gcs.fc_master_slave = no;
gcs.max_packet_size = 64500; gcs.max_throttle = 0.25; gcs.recv_q_hard_limit =
9223372036854775807; gcs.recv_q_soft_limit = 0.25; gcs.sync_donor = no;
gmcast.listen_addr = tcp://0.0.0.0:4567; gmcast.mcast_addr = ; gmcast.mcast_ttl
= 1; gmcast.peer_timeout = PT3S; gmcast.segment = 0; gmcast.time_wait = PT5S;
gmcast.version = 0; ist.recv_addr = localhost; pc.announce_timeout = PT3S;
pc.checksum = false; pc.ignore_quorum = false; pc.ignore_sb = false; pc.linger
= PT20S; pc.npvo = false; pc.recovery = true; pc.version = 0; pc.wait_prim =
true; pc.wait_prim_timeout = PT30S; pc.weight = 1; protonet.backend = asio;
protonet.version = 0; repl.causal_read_timeout = PT30S; repl.commit_order = 3;
repl.key_format = FLAT8; repl.max_ws_size = 2147483647; repl.proto_max = 7;
socket.checksum = 2; socket.recv_buf_size = 212992;
wsrep_recover	OFF
wsrep_replicate_myisam	OFF
wsrep_restart_slave	OFF
wsrep_retry_autocommit	1
wsrep_slave_fk_checks	ON
wsrep_slave_uk_checks	OFF
wsrep_slave_threads	1
wsrep_sst_auth
wsrep_sst_donor
wsrep_sst_donor_rejects_queries	OFF
wsrep_sst_method	rsync
wsrep_sst_receive_address	AUTO
wsrep_start_position	00000000-0000-0000-0000-000000000000:-1
wsrep_sync_wait	0
$ ss -lntu
Netid  State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
tcp    LISTEN     0      100       *:1248                  *:*
tcp    LISTEN     0      80        *:3306                  *:*
tcp    LISTEN     0      128       *:4567                  *:*
tcp    LISTEN     0      50        *:1247                  *:*
usermod: no changes
usermod: no changes
```
