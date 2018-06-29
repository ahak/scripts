#!/usr/bin/awk -f

function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}


function print_read_to_file (filename)
{ 
    for (i= 1; i<=3; i++) {
	print >> filename; getline;
    }
    print >> filename
}

NR == 1 {
    n = split(FILENAME, fname, ".");
    base = join(fname, 1, n-1, ".")
    pair1 = base "_1.fastq"
    pair2 = base "_2.fastq"
    single = base "_single.fastq"
}

$0 ~ /\/1$/ {
    print_read_to_file(pair1)
    getline
    print_read_to_file(pair2)
    next
}

$0 !~ /\/1$/ {
    print_read_to_file(single)
}
