alter table deapp.de_subject_sample_mapping add primary key(assay_id);

create table deapp.mutation (
  mutation_event_id integer not null,
  assay_id integer not null,
  center varchar(100),
  sequencer varchar(255),
  mutation_status varchar(25),
  validation_status varchar(25),
  tumor_seq_allele1 varchar(255),
  tumor_seq_allele2 varchar(255),
  matched_norm_sample_barcode varchar(255),
  match_norm_seq_allele1 varchar(255),
  match_norm_seq_allele2 varchar(255),
  tumor_validation_allele1 varchar(255),
  tumor_validation_allele2 varchar(255),
  match_norm_validation_allele1 varchar(255),
  match_norm_validation_allele2 varchar(255),
  verification_status varchar(10),
  sequencing_phase varchar(100),
  sequence_source varchar(255) not null,
  validation_method varchar(255),
  score varchar(100),
  bam_file varchar(255),
  tumor_alt_count integer,
  tumor_ref_count integer,
  normal_alt_count integer,
  normal_ref_count integer,
  amino_acid_change varchar(255),
  foreign key (mutation_event_id) references deapp.mutation_event (mutation_event_id) on delete cascade,
  foreign key (assay_id) references deapp.de_subject_sample_mapping (assay_id) on delete cascade
);

-- constraint to block duplicated mutation entries
alter table deapp.mutation add primary key(mutation_event_id,assay_id);

comment on table deapp.mutation is 'mutation data details';
