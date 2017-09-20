#!/bin/sh
#for i in {1..1}; do time java -jar flix.jar --optimize --verifier *.flix; done
for i in {1..1}; do time java -jar flix.jar --optimize --verifier --print SUPT.VarPointsTo_FI,SUPT.FieldPointsTo_FI,SUPT.TargetHeapLocation_FI *.flix; done