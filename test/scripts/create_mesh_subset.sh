#!/usr/bin/env bash

cat $1 | grep \
-e '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://id.nlm.nih.gov/mesh/vocab#TopicalDescriptor>' \
-e '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://id.nlm.nih.gov/mesh/vocab#SCR_Chemical>' \
-e '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://id.nlm.nih.gov/mesh/vocab#SCR_Disease>' \
-e '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://id.nlm.nih.gov/mesh/vocab#SCR_Protocol>' \
-e 'http://id.nlm.nih.gov/mesh/A01.456.505.420' \
-e 'http://id.nlm.nih.gov/mesh/A17.360' \
-e 'http://id.nlm.nih.gov/mesh/C025735' \
-e 'http://id.nlm.nih.gov/mesh/C04' \
-e 'http://id.nlm.nih.gov/mesh/C041293' \
-e 'http://id.nlm.nih.gov/mesh/C09.218.568' \
-e 'http://id.nlm.nih.gov/mesh/D000001' \
-e 'http://id.nlm.nih.gov/mesh/D000926' \
-e 'http://id.nlm.nih.gov/mesh/D001583' \
-e 'http://id.nlm.nih.gov/mesh/D005123' \
-e 'http://id.nlm.nih.gov/mesh/D005138' \
-e 'http://id.nlm.nih.gov/mesh/D006197' \
-e 'http://id.nlm.nih.gov/mesh/D007759' \
-e 'http://id.nlm.nih.gov/mesh/D007762' \
-e 'http://id.nlm.nih.gov/mesh/D009369' \
-e 'http://id.nlm.nih.gov/mesh/D011434' \
-e 'http://id.nlm.nih.gov/mesh/D012343' \
-e 'http://id.nlm.nih.gov/mesh/D012345' \
-e 'http://id.nlm.nih.gov/mesh/D012346' \
-e 'http://id.nlm.nih.gov/mesh/D012677' \
-e 'http://id.nlm.nih.gov/mesh/D013514' \
-e 'http://id.nlm.nih.gov/mesh/D013517' \
-e 'http://id.nlm.nih.gov/mesh/D015834' \
-e 'http://id.nlm.nih.gov/mesh/D015837' \
-e 'http://id.nlm.nih.gov/mesh/D018159' \
-e 'http://id.nlm.nih.gov/mesh/D03.438.221' \
-e 'http://id.nlm.nih.gov/mesh/D055687' \
-e 'http://id.nlm.nih.gov/mesh/D13.444.735.757' \
-e 'http://id.nlm.nih.gov/mesh/E01.370.386.460' \
-e 'http://id.nlm.nih.gov/mesh/E01.370.388.250.525' \
-e 'http://id.nlm.nih.gov/mesh/E04.502.250.525' \
-e 'http://id.nlm.nih.gov/mesh/E04.580.068' \
-e 'http://id.nlm.nih.gov/mesh/E04.580.373' \
-e 'http://id.nlm.nih.gov/mesh/E04.580.848' \
-e 'http://id.nlm.nih.gov/mesh/F02.830.816.541' \
-e 'http://id.nlm.nih.gov/mesh/F02.830.816.964' \
-e 'http://id.nlm.nih.gov/mesh/G02.111.087.800.480.900' \
-e 'http://id.nlm.nih.gov/mesh/G02.149.115.800.480.900' \
-e 'http://id.nlm.nih.gov/mesh/G04.299.880.480.900' \
-e 'http://id.nlm.nih.gov/mesh/G05.360.335.060' \
-e 'http://id.nlm.nih.gov/mesh/G11.427.690' \
-e 'http://id.nlm.nih.gov/mesh/G11.561.600.810.541' \
-e 'http://id.nlm.nih.gov/mesh/G11.561.600.810.964' \
-e 'http://id.nlm.nih.gov/mesh/G14.640.816' \
-e 'http://id.nlm.nih.gov/mesh/M0000001' \
-e 'http://id.nlm.nih.gov/mesh/M0008101' \
-e 'http://id.nlm.nih.gov/mesh/M0014584' \
-e 'http://id.nlm.nih.gov/mesh/M0014585' \
-e 'http://id.nlm.nih.gov/mesh/M0014586' \
-e 'http://id.nlm.nih.gov/mesh/M0085467' \
-e 'http://id.nlm.nih.gov/mesh/M0085468' \
-e 'http://id.nlm.nih.gov/mesh/M0353609' \
-e 'http://id.nlm.nih.gov/mesh/T000001' \
-e 'http://id.nlm.nih.gov/mesh/T000002' \
-e 'http://id.nlm.nih.gov/mesh/T000003' \
-e 'http://id.nlm.nih.gov/mesh/T000004' \
-e 'http://id.nlm.nih.gov/mesh/T000024' \
-e 'http://id.nlm.nih.gov/mesh/T000025' \
-e 'http://id.nlm.nih.gov/mesh/T000206' \
-e 'http://id.nlm.nih.gov/mesh/T015707' \
-e 'http://id.nlm.nih.gov/mesh/T027925' \
-e 'http://id.nlm.nih.gov/mesh/T027926' \
-e 'http://id.nlm.nih.gov/mesh/T027927' \
-e 'http://id.nlm.nih.gov/mesh/T027928' \
-e 'http://id.nlm.nih.gov/mesh/T027929' \
-e 'http://id.nlm.nih.gov/mesh/T115467' \
-e 'http://id.nlm.nih.gov/mesh/T115468' \
-e 'http://id.nlm.nih.gov/mesh/T115469' \
-e 'http://id.nlm.nih.gov/mesh/T115470' \
-e 'http://id.nlm.nih.gov/mesh/T115471' \
-e 'http://id.nlm.nih.gov/mesh/T365903' \
-e 'http://id.nlm.nih.gov/mesh/T365904' \
-e 'http://id.nlm.nih.gov/mesh/T646365' \
-e 'http://id.nlm.nih.gov/mesh/T751239' \
-e 'http://id.nlm.nih.gov/mesh/T811395' \
-e 'http://id.nlm.nih.gov/mesh/T811769' \
-e 'http://id.nlm.nih.gov/mesh/T811770' \
-e 'http://id.nlm.nih.gov/mesh/T814292' \
-e 'http://id.nlm.nih.gov/mesh/T816277' \
> $(dirname $1)/mesh_subset.nt
