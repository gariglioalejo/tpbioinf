Instrucciones de ejecucución:

Para ejecutar BLAST de manera offline:

1- Instalar localmente BLAST en /home/manager/bio/ncbi-blast-2.4.0+/bin/blastp

2- Bajar la BD Swisprot en /home/manager/bio/swissprot

3- Ingresar el input fasta en /home/manager/bio/input/CYP11B1_mRNA_traducido.fasta

4- Crear la carpeta /home/manager/bio/out/

5- Ejecutar ej-scriptlocal.sh con permisos de root


Para ejecutar de manera online situar el archivo de input en el mismo lugar y ejecutar:

perl ej2_online.pl

Este último requiere conexión directa a internet (no funciona si se utilza un proxy)


