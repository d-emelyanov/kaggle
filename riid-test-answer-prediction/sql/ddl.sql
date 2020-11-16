{% sql 'create_table_lectures' %}
CREATE TABLE IF NOT EXISTS riid.lectures (
	lecture_id UInt32,
	tag UInt32,
	part UInt32,
	type_of String
) ENGINE=MergeTree
ORDER BY lecture_id
{% endsql %}

{% sql 'create_table_questions' %}
CREATE TABLE IF NOT EXISTS riid.questions (
	question_id UInt32,
	bundle_id UInt32,
	correct_answer Int32,
	part Int32,
	tags String
) ENGINE=MergeTree
ORDER BY question_id
{% endsql %}

{% sql 'create_table_train' %}
CREATE TABLE riid.train (
	row_id UInt32,
	timestamp UInt64,
	user_id UInt32,
	content_id UInt32,
	content_type_id UInt8,
	task_container_id UInt32,
	user_answer Int32,
	answered_correctly Int32,
	prior_question_elapsed_time Float64,
	prior_question_had_explanation String
) ENGINE=MergeTree
ORDER BY (row_id, user_id, content_id)
{% endsql %}