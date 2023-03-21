#!/bin/bash

# Generates 520 Vault entities, then assigns them to a group
# Used to test group exhaustion theory

GROUPNAME=treehouse
COUNT=$(vault read identity/group/name/hmm -format=json | jq '.data.member_entity_ids | length')
for i in {1..520}
do
	vault write -field=id identity/entity name=conor_clone_no_${i} policies=test
done

ENTITIES=$(vault list identity/entity/id | sed 1,2d | tr '\n' ',' | sed 's/.$//')

vault write identity/group name=$GROUPNAME member_entity_ids="$ENTITIES"

echo "------------------------------------"
echo "Member count for $GROUPNAME is $COUNT"
