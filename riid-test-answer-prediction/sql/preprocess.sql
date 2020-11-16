{% sql 'data_lectures' %}
CREATE TABLE IF NOT EXISTS
    data_lectures
    ENGINE=MergeTree
    ORDER BY (row_id, user_id, content_id)
AS SELECT
        tr.*,
        lec.tag,
        lec.part,
        lec.type_of
    FROM (
        SELECT
            row_id,
            timestamp,
            user_id,
            content_id,
            task_container_id
        FROM riid.train
        WHERE content_type_id=1
    ) tr
    LEFT JOIN riid.lectures lec ON (tr.content_id=lec.lecture_id)
{% endsql %}


{% sql 'data_questions' %}
CREATE TABLE IF NOT EXISTS
    data_questions
    ENGINE=MergeTree
    ORDER BY (row_id, user_id, content_id)
AS SELECT
    t.row_id,
    t.user_id,
    t.content_id,
    t.answered_correctly target
FROM train t
LEFT JOIN questions q ON (t.content_id=q.question_id)
WHERE
    t.content_type_id=0
{% endsql %}


{% sql 'feature_questions_flat' %}
CREATE TABLE IF NOT EXISTS
    feature_questions_flat
    ENGINE=MergeTree
    ORDER BY (row_id, user_id, content_id)
AS SELECT
    row_id,
    user_id,
    content_id,
    CASE
        WHEN t.prior_question_had_explanation = 'FALSE' THEN 0
        WHEN t.prior_question_had_explanation = 'TRUE' THEN 1
        ELSE -1
    END AS prior_question_had_explanation,
    CASE
        WHEN q.part >= 1 and q.part <= 4 THEN 'listening'
        WHEN q.part >= 5 and q.part <= 7 THEN 'reading'
    END AS question_type,
    CASE
        WHEN t.prior_question_had_explanation = '' THEN 1
        ELSE 0
    END AS is_first_question,
    part
FROM train t
LEFT JOIN questions q ON (t.content_id=q.question_id)
WHERE
    t.content_type_id=0
{% endsql %}