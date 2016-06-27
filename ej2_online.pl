#!/bin/perl -w

#Remote-blast "factory object" creation and blast-parameter initialization

  use Bio::Tools::Run::RemoteBlast;
  use strict;
  my $prog = 'blastp';
  my $db   = 'swissprot';
  my $e_val= '1e-10';

  my @params = ( '-prog' => $prog,
         '-data' => $db,
         '-expect' => $e_val,
         '-readmethod' => 'SearchIO' );

  my $factory = Bio::Tools::Run::RemoteBlast->new(@params);

 
  #$Bio::Tools::Run::RemoteBlast::HEADER{'ENTREZ_QUERY'} = 'Homo sapiens [ORGN]';
  #$Bio::Tools::Run::RemoteBlast::HEADER{'MATRIX_NAME'} = 'BLOSUM45';


  #$Bio::Tools::Run::RemoteBlast::RETRIEVALHEADER{'DESCRIPTIONS'} = 1;
  #$Bio::Tools::Run::RemoteBlast::RETRIEVALHEADER{'ALIGNMENTS'} = 10000;


  my $v = 1;

  my $str = Bio::SeqIO->new(-file=>'/home/manager/bio/input/CYP11B1_mRNA_traducido.fasta' , -format => 'fasta' );

  while (my $input = $str->next_seq()){
    
    my $r = $factory->submit_blast($input);
  
    print STDERR "waiting..." if( $v > 0 );
    while ( my @rids = $factory->each_rid ) {
      foreach my $rid ( @rids ) {
        my $rc = $factory->retrieve_blast($rid);
        if( !ref($rc) ) {
          if( $rc < 0 ) {
            $factory->remove_rid($rid);
          }
          print STDERR "." if ( $v > 0 );
          sleep 5;
        } else {
          my $result = $rc->next_result();
          #save the output
          my $filename = $result->query_name()."\.out";
          $factory->save_output($filename);
          $factory->remove_rid($rid);
          print "\nQuery Name: ", $result->query_name(), "\n";
          while ( my $hit = $result->next_hit ) {
            next unless ( $v > 0);
            print "\thit name is ", $hit->name, "\n";
            while( my $hsp = $hit->next_hsp ) {
              print "\t\tscore is ", $hsp->score, "\n";
            }
          }
        }
      }
    }
  }

