Feature: Print out the list
  In order to know what to do
  I want to be able to print my list to the console
  So that I can get feedback on what to do next

  Background:
    Given I have a fresh temporary "/tmp/todo.txt" file

  Scenario: Listing the tasks
    When I successfully run `todotxt_rb -f /tmp/todo.txt list`
    Then the stdout should contain "Clean desk"

  Scenario: Using the 'ls' alias
    When I successfully run `todotxt_rb -f /tmp/todo.txt ls`
    Then the stdout should contain "Clean desk"

  Scenario: Using the 'listcon' command
    When I successfully run `todotxt_rb -f /tmp/todo.txt listcon`
    Then the stdout should contain "@work"
    But the stdout should not contain "Clean desk"

  Scenario: Using the 'listpri' command
    When I successfully run `todotxt_rb -f /tmp/todo.txt listpri`
    Then the stdout should contain "A"
    But the stdout should not contain "Clean desk"

  Scenario: Using the 'listproj' command
    When I successfully run `todotxt_rb -f /tmp/todo.txt listproj`
    Then the stdout should contain "+NewSiteProject"
    But the stdout should not contain "Clean desk"
