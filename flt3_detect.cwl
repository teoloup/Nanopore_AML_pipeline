class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: flt3_detect
baseCommand:
  - flte_detect.py
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-b'
outputs:
  - id: FLT3_results
    type: Directory
    outputBinding:
      glob: output_dir
label: flt3_detect
arguments:
  - position: 0
    prefix: '-n'
    valueFrom: sample_name
  - position: 0
    prefix: '--min-supporting-reads'
    valueFrom: '20'
  - position: 0
    prefix: '--min-allele-frequency'
    valueFrom: '0.005'
  - position: 0
    prefix: '--threads'
    valueFrom: '16'
  - position: 0
    prefix: '-o'
    valueFrom: output_dir
