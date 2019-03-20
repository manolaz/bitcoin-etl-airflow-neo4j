USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM "{{uri}}" AS row
MERGE (t:Transaction {hash: row.hash})
ON CREATE SET 
		t.hash = row.hash,
        t.block_height = toInteger(row.block_number),
		t.size = toInteger(row.size),
		t.virtual_size = toInteger(row.virtual_size),
		t.version = toInteger(row.version),
		t.lock_time = toInteger(row.lock_time),
		t.is_coinbase = row.is_coinbase,
		t.input_count = toInteger(row.input_count),
		t.output_count = toInteger(row.output_count)
WITH t, row
   MATCH (b:Block {height: toInteger(row.block_number)})	
   MERGE (t)-[:at]->(b);