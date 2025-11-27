class: Workflow
cwlVersion: v1.0
id: aml_nanopore_panel
label: AML_nanopore_panel
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastq.gz
    type: File
    'sbg:x': 110.98446655273438
    'sbg:y': -89.20313262939453
  - id: reference_file
    type: File
    'sbg:x': 728.5316772460938
    'sbg:y': -91.52275848388672
  - id: bed_file
    type: File
    'sbg:x': 1066.8690185546875
    'sbg:y': -212.7391815185547
  - id: annovar_dbs
    type: Directory
    'sbg:x': 2057.477294921875
    'sbg:y': 302.1165466308594
outputs:
  - id: FLT3_results
    outputSource:
      - flt3_detect/FLT3_results
    type: Directory
    'sbg:x': 2498.52490234375
    'sbg:y': 396.01666259765625
  - id: annotated.vcf
    outputSource:
      - annovar_table_annovar_pl/annotated.vcf
    type: File
    'sbg:x': 2507.710693359375
    'sbg:y': 180.65625
steps:
  - id: porechop
    in:
      - id: fastq.gz
        source: fastq.gz
    out:
      - id: output
    run: ./porechop.cwl
    label: porechop
    'sbg:x': 330.4439697265625
    'sbg:y': -46.97115707397461
  - id: minimap2
    in:
      - id: reference_file
        source: reference_file
      - id: fastq
        source: porechop/output
    out:
      - id: aligned.bam
    run: ./minimap2.cwl
    label: minimap2
    'sbg:x': 563.2808227539062
    'sbg:y': 22.112089157104492
  - id: samtools_view__sb
    in:
      - id: aligned_sam
        source: minimap2/aligned.bam
    out:
      - id: aligned_bam
    run: ./samtools_view_sb.cwl
    label: samtools_view_Sb
    'sbg:x': 710.2308349609375
    'sbg:y': 188.34295654296875
  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view__sb/aligned_bam
    out:
      - id: sorted
    run: ./samtools_sort.cwl
    label: samtools_sort
    'sbg:x': 912.4439697265625
    'sbg:y': 336.6392822265625
  - id: samtools_index_bam
    in:
      - id: bam_file
        source: samtools_sort/sorted
    out: []
    run: ./samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 1012.574951171875
    'sbg:y': 433.9079284667969
  - id: flt3_detect
    in:
      - id: input
        source: samtools_sort/sorted
    out:
      - id: FLT3_results
    run: ./flt3_detect.cwl
    label: flt3_detect
    'sbg:x': 1404.7901611328125
    'sbg:y': 485.2963562011719
  - id: picard_addorreplacereadgroups
    in:
      - id: sorted_dedup_bam
        source: samtools_sort/sorted
    out:
      - id: dedup_RG_bam
    run: ./picard_addorreplacereadgroups.cwl
    label: picard_AddOrReplaceReadGroups
    'sbg:x': 1129.87353515625
    'sbg:y': 244.8368682861328
  - id: samtools_index_bam_1
    in:
      - id: bam_file
        source: picard_addorreplacereadgroups/dedup_RG_bam
    out: []
    run: ./samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 1273.9989013671875
    'sbg:y': 369.6126708984375
  - id: gatk_mutect2_tumoronly
    in:
      - id: ref_fasta
        source: reference_file
      - id: bam
        source: picard_addorreplacereadgroups/dedup_RG_bam
      - id: bed_file
        source: bed_file
    out:
      - id: vcf
    run: ./gatk_mutect2_tumoronly.cwl
    label: gatk_Mutect2_tumorOnly
    'sbg:x': 1365.213134765625
    'sbg:y': 89.46060180664062
  - id: gatk_filtermutectcalls
    in:
      - id: ref_file
        source: reference_file
      - id: vcf_file
        source: gatk_mutect2_tumoronly/vcf
    out:
      - id: filtered_vcf
    run: ./gatk_filtermutectcalls.cwl
    label: gatk_FilterMutectCalls
    'sbg:x': 1601.1964111328125
    'sbg:y': 14.771368026733398
  - id: clairs
    in:
      - id: input_bam
        source: picard_addorreplacereadgroups/dedup_RG_bam
      - id: reference_genome
        source: reference_file
    out:
      - id: output
    run: ./clairs.cwl
    label: ClairS
    'sbg:x': 1373.738037109375
    'sbg:y': 243.83351135253906
  - id: annovar_table_annovar_pl
    in:
      - id: Convert_2_Annovar.avinput
        source: annovar_convert2annovar/Convert_2_Annovar.avinput
      - id: annovar_dbs
        source: annovar_dbs
    out:
      - id: annotated.vcf
    run: ./annovar_table_annovar-pl.cwl
    label: annovar_table_annovar.pl
    'sbg:x': 2186.91845703125
    'sbg:y': 173.65625
  - id: annovar_convert2annovar
    in:
      - id: filtered.vcf.gz
        source: merge_results/out_vcf
    out:
      - id: Convert_2_Annovar.avinput
    run: ./annovar_convert2annovar.cwl
    label: Annovar_convert2annovar
    'sbg:x': 1944.90234375
    'sbg:y': 177.60598754882812
  - id: merge_results
    in:
      - id: '--vcf1'
        source: clairs/output
      - id: vcf2
        source: gatk_filtermutectcalls/filtered_vcf
    out:
      - id: out_vcf
    run: ./merge_results.cwl
    label: merge_results
    'sbg:x': 1728.2952880859375
    'sbg:y': 165.65371704101562
requirements: []
