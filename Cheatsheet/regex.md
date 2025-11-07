1. Match every odd lines : `^(.+)(\n)(.+\n)?`
2. Replacement : `$1 .$2. $3`
3. Match odd numbers `^\d*[13579]$`
4. Match even numbers `^\d*[02468]$`
5. Match blank lines `^\s*$`
