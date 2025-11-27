class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: clairs
baseCommand:
  - run_clairs_to
inputs:
  - id: input_bam
    type: File
    inputBinding:
      position: 0
      prefix: '--tumor_bam_fn'
  - id: reference_genome
    type: File
    inputBinding:
      position: 0
      prefix: '--ref_fn'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: '--output_dir'
label: ClairS
arguments:
  - position: 0
    prefix: '--sample_name'
    valueFrom: sample_name
  - position: 0
    prefix: '--threads'
    valueFrom: '16'
  - position: 0
    prefix: '--platform'
    valueFrom: ont_r10_dorado_sup_4khz
  - position: 0
    prefix: '--output_dir'
    valueFrom: directory
  - position: 0
    prefix: ''
    valueFrom: '--disable_nonsomatic_tagging'
