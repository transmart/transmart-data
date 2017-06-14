create table deapp.mutation_event (
  mutation_event_id serial,
  gpl_id character varying(100) not null,
  entrez_gene_id integer not null,
  chr varchar(5),
  start_position bigint,
  end_position bigint,
  reference_allele varchar(400),
  tumor_seq_allele varchar(400),
  protein_change varchar(255),
  mutation_type varchar(255),
  functional_impact_score varchar(50),
  fis_value float,
  link_xvar varchar(500),
  link_pdb varchar(500),
  link_msa varchar(500),
  ncbi_build varchar(10),
  strand varchar(2),
  variant_type varchar(15),
  db_snp_rs varchar(25),
  db_snp_val_status varchar(255),
  oncotator_dbsnp_rs varchar(255),
  oncotator_refseq_mrna_id varchar(64),
  oncotator_codon_change varchar(255),
  oncotator_uniprot_entry_name varchar(64),
  oncotator_uniprot_accession varchar(64),
  oncotator_protein_pos_start integer,
  oncotator_protein_pos_end integer,
  primary key (mutation_event_id)
);

create unique index mutation_event_uq_indx on deapp.mutation_event(ncbi_build, chr, start_position, end_position, tumor_seq_allele, entrez_gene_id, protein_change, mutation_type);

comment on table deapp.mutation_event is 'mutation data';
comment on column deapp.mutation_event.mutation_type is 'e.g. missense, nonsence, etc.';
comment on column deapp.mutation_event.functional_impact_score is 'result from oma/xvar.';
comment on column deapp.mutation_event.link_xvar is 'link to oma/xvar landing page for the specific mutation.';