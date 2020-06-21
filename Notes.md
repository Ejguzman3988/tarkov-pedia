How to Build a Gem 

1. Plan your gem, imagine your interface
2. Start with the project structure - google
3. Start with the entry point - the file run
4. force that to build the CLI interface
5. stub out the interface
6. start making things real
7. discover objects
8. program



- A command line interface for tarkov, starting item price

-> tarkov-pedia

1. check item 
2. check quest
.
.
.
---
Idea it will be able to check for ballistics, character skills, characters, health, hideout, items, quests,  price, etc
---

Example of how to code would run:

-> tarkov-pedia
What would you like to search.
1. item 
2. quest
.
.
.

-> item 

What item?

-> Tushonka

Which process would you like to do?

1. description (found on tarkov game pedia)

2. price (found on tarkov - market)

3. go back to menu (returns to previous menu)

-> price

The last lowest price of Tushonka on the marketplace was 8,000₽.

What else would you like to do?

1. description (found on tarkov game pedia)

2. price (found on tarkov - market)

3. go back (returns to previous menu)

-> description

Canned beef stew, commonly referred to as tushonka, can be stored for years, thus rivaling condensed milk in importance as military and tourist food supply.

1. Would you like to search something else?

2. Back to main menu


Person puts in what type of search they want
Person puts in the name of what they want to search

-- Program should check if the name is available -- 

This would require me to scrape a site. 
Currently with my Diagram, I do not do this.

Future reference, I need to change diagram and add functionality

--TO DO Later-- 



Person puts in what type of search they want - Items
--Create a loop until they pick the right menu item

Person puts in the name of what they want to search - Tushonka
--Create a loop until they search for a proper item

Person puts in process
--Create a loop until they pick the right process

Person chooses what to do after they get their results
--Creates a loop until they exit

Need to fix Flow Chart!


To Do Next:

Create functionality of the pedia class

When a new pedia class is created.

Check if the pedia exists already. 
    then delete or pull data
Store data from scrapper.

Gives specified data to cli.

Pedia has a interest
pedia has a name
pedia has a process

