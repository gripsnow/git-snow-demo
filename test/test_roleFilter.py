from scripts.filter import filter_by_role
from snowflake.snowpark.session import Session

def test_roleFilter_returns_results_based_on_specified_roles(session: Session):
    #Arrange
    source_data = [
        [ 1, 'Alice', 'op'],
        [ 2, 'Bob', 'dev'],
        [ 3, 'Cindy', 'dev']
    ]

    schema = ['id', 'name', 'role']
    session.createDataFrame(source_data, schema) \
        .write.mode('overwrite') \
        .save_as_table('employees')

    #Act
    resulting_df = filter_by_role(session, 'employees', 'dev')    

    #Assert
    expected_data = [
        [ 2, 'Bob', 'dev'],
        [ 3, 'Cindy', 'dev']     
    ]
 
    expected_df = session.createDataFrame(expected_data, schema)
    assert(resulting_df.collect() == expected_df.collect())
