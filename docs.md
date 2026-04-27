### Kern flags


| Flag    | Description                                                   | Example                               |
|---------|---------------------------------------------------------------|----------------------------------------|
| -f      | All arguments until the next flag are treated as input files  | `kernc -f file1.cf file2.cf`             |
| -o      | The next argument is the output file                          | `kernc -o outputfile`                    |
| -i      | All arguments until the next flag are include directories     | `kernc -i include/ libs/`                |
| -l      | All arguments until the next flag are libraries to link       | `kernc -l sdl2`                          |
| -ldir   | All arguments until the next flag are library search paths    | `kernc -ldir /usr/local/bin/`            |
| -shared | Marks the output file as a shared library                     | `kernc -f test.cf -o test.so -shared`    |
| -app    | All arguments until the next flag are preprocesser addons     |  `kernc -app  my_addon.lua`               |