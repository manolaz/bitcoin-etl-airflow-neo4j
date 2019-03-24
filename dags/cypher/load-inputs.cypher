USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM "{{uri}}" AS row
MATCH (t:Transaction {hash: row.hash, block_height: toInteger(row.block_height)})
MERGE (i:Output {tx_hash: row.spent_transaction_hash, output_index: toInteger(row.spent_output_index)})
 ON MATCH SET 
		i.input_index = toInteger(row.index),
		i.is_spent = toBoolean(true),
		i.spending_tx_hash = row.hash
MERGE (i)-[:sent]->(t);
