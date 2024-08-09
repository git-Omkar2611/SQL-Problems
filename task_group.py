from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.utils.task_group import TaskGroup  # Add this import
from datetime import datetime,timedelta
from airflow.models import Variable

default_args = {
    'start_date': datetime(2024, 1, 1),
    'retries': 3,
    'retry_delay': timedelta(seconds=30)
}

dag = DAG('example_dag', default_args=default_args, schedule_interval=None)

def first_func():
    val = 2
    if val%2==0:
        print("its even")

def second_func():
    val=int(Variable.get("ExampleValue"))
    if val%2==0:
        print("its even")
    else:
        raise ValueError("Number is not even")    

with dag:
    with TaskGroup("group1") as group1:
        
        task1 = BashOperator(task_id='task1' , bash_command= 'echo Task1')
        task2 = BashOperator(task_id='task2' , bash_command= 'echo Task2')
        
        task1 >> task2  # Set downstream dependency within the task group

        task3 = PythonOperator(
            task_id='task3',
            python_callable=first_func
        )

        task4 = PythonOperator(
            task_id='task4',
            python_callable=second_func
        )

        task3 >> task4

    task5 = BashOperator(task_id='task5' ,  bash_command= 'echo Task5')

    # Define dependencies
    group1 >> task5

