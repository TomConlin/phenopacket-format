
all: test all_json
test: test_examples

EXAMPLES=omim-example patient-example variant-example journal-example
all_json: all_json_l1
all_json_l1: $(patsubst %,examples/level-1/%-l1.json,$(EXAMPLES))

test_examples: test_examples_l1
test_examples_l1: $(patsubst %,examples/level-1/%-l1.report,$(EXAMPLES))


%.json: %.yaml
	util/yaml2json.py $< > $@.tmp && mv $@.tmp $@

%.report: %.yaml
	kwalify -E -f schema/phenopacket-level-1-schema.yaml $< 
#	kwalify -E -f schema/phenopacket-level-1-schema.yaml $<  2>&1 | tee out.log && grep 'INVALID\|ERROR' out.log; test $? -ne 0
