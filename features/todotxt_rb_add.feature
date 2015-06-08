Feature: Add a task to the list
  In order to construct a todo list
  I want to be able to add a task
  So I can keep track of them and mark them off later

  Background:
    Given I have a fresh temporary "/tmp/todo.txt" file

  Scenario: Adding a task
    When I successfully run `todotxt_rb -f /tmp/todo.txt add 'Some new task'`
    Then I successfully run `todotxt_rb -f /tmp/todo.txt list`
    And the stdout should contain "Some new task"

  Scenario: Adding a task using the 'a' alias
    When I successfully run `todotxt_rb -f /tmp/todo.txt a 'Some new task'`
    Then I successfully run `todotxt_rb -f /tmp/todo.txt list`
    And the stdout should contain "Some new task"
