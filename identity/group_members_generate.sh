#!/bin/bash

# Generates 520 Vault entities, then assigns them to a group
# Used to test group exhaustion theory

for i in {1..520}
do
	vault write -field=id identity/entity name=conor_clone_no_${i} policies=test
done

ENTITIES=$(vault list identity/entity/id | sed 1,2d | tr '\n' ',' | sed 's/.$//')

vault write identity/group name=treehouse member_entity_ids="$ENTITIES"
