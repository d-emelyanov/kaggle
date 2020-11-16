## Upload csv to clickhouse

```
wc -l <file>
```

```
split -l <lines> <file>
```

```
clickhouse client --query="INSERT INTO <table> FORMAT CSVWithNames" < <file>
```