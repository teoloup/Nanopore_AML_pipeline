class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: merge_results
baseCommand:
  - mergevcfs.py
inputs:
  - id: '--vcf1'
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
  - id: vcf2
    type: File
    inputBinding:
      position: 0
      prefix: '-i'
outputs:
  - id: out_vcf
    type: File
    outputBinding:
      glob: merged_vcf
label: merge_results
arguments:
  - position: 0
    prefix: '-n'
    valueFrom: CallerName1
  - position: 0
    prefix: '-N'
    valueFrom: CallerName2
  - position: 0
    prefix: '-o'
    valueFrom: merged_vcf
