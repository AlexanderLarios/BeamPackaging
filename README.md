The Boxing Kata
=================

Setup
-----
Using ruby 2.7.1

```
bundle install
bin/rspec
```

Run the Beam Boxer CLI and add an argument with the csv file path. Example with provided csv below. Please note that '<' from original readme instructions has been removed to use ARGV for Ruby IO best practices.


```
ruby ./bin/boxing-kata spec/fixtures/family_preferences.csv
```
Technical Decision-Making and Dev Log
----------
**Day1 (9/25 - Friday Night):**  Read the ReadMe, Created Repo, added initial commit, updated gitIgnore, added Ruby Version file. Enjoyed some sweet work life balance.

**Day2 (9/26 - Saturday Afternoon):**
Implemented the first two stories to get the family preferences from csv file and output their preferences.
 Implemented the Rspec tests around those work flows. Read up on the next stories, so I can work on tech design in the back of my mind while I enjoyed some more of that sweet work life balance.

**Day3 (9/27 - Sunday Early Afternoon):**
I started to implement a box class and starter box work flow but noticed that the STDIN was not tied to a TTY (basically the terminal).
This was preventing the implementation of a command line interface (CLI) using STDIN.gets calls because STDIN was still tied to the file input from the entry point instead of a TTY.
After a bit of reading in the ruby best practice docs for IO and TTY I decided to fix the issue by updating the entry point to use ARGV command line arguments because it was a simple and well documented solution.
At this point I also created a CLI scaffolding using TTY-Prompt gem because it seemed like a pretty straight forward way to avoid some boiler plate CLI code. 
The TTY-Prompt gem also let me add some personal style to my standard CLI in the form of arrow key selectable menu options.

**Day3 (9/27 - Sunday Afternoon):**
Made this ReadMe and Dev Log section because I felt like I should probably point out and explain why I changed the default entry point into the program while it was fresh in my mind.

**Day3 (9/27 - Sunday Evening):**
Implemented the functionality and tests for generate starter box and generate refill box work flows. It was pretty straight forward and used the family as a pseudo box factory class to keep the code dry. Added some extra CSV files to spec/fixtures for exploratory testing and looking for things that the Rspecs might miss with the CLI. Having a lot of fun with this project and writing pure ruby for a change.]

**Day3 (9/27 - Sunday Night):**
Implemented the shipping schedule story for starter and refill box work flows and the corresponding Rspec tests. Nice when the pieces fall into place pretty easily. Seems like its down hill from here.

Implemented shipping calculation for boxes based on weight and corresponding Rspec tests.

Implemented paste kits and corresponding Rspec tests. Assumed this did not impact how much could fit in each box as it was not mentioned.

**Conclusion:** I enjoyed implementing this project. Feel free to reach out to me with feedback. There is a short list of additional features I would like to add to the project, but I am out of time for this weekend. Here are some of those items: Error Handling, CSV validation and rescue, CSV batching using ARGV arguments, add constants and i18n, DB input.
 
 If you made it this far, thanks for taking the time to check out my work!

Original Read Me Instructions
------------
Everyone who has dental insurance through Beam receives perks in the form of electric toothbrushes, replacement brush heads, and paste kits (toothpaste and floss). These perks are provided at the start of an insurance contract and then semi-frequently throughout the life of the contract. Each family member gets to choose a toothbrush color at enrollment, and will receive replacement toothbrush heads of the same color.

This kata involves building the brains of a boxing system which will determine how the perks are boxed up and shipped. Given a family's brush color preferences, the system will generate a description of how the boxes should be filled. A shipping manager must be able to load data for a family, create starter and refill boxes, and perform other operations in real-time. The focus of this kata should be building a library for the system rather than a UI.

Instructions
------------
Please read through the user stories below and implement the functionality to complete them according to their requirements. The design is entirely up to you as long as the solution can be run via the entry point in the bin directory (see below).

Beam firmly believes in testing as a practice and as such we ask that you please add tests. We also ask that you commit your work to git frequently as you go.

Please add a section explaining the technical decision making involved in designing your solution. What options were you considering at various levels (eg. tech stack choice, libraries, and design, as applicable) and what were the tradeoffs in choosing one option over another? Feel free to include this section here in this README.

Setup
-----

```
bundle install
bin/rspec
```

An entry point has been provided:

```
ruby ./bin/boxing-kata <spec/fixtures/family_preferences.csv
```

Submitting your work to Beam
--------------------

Please include a `.ruby-version` file with your submission. There are differences between versions that can be significant to your application's runtime versus your reviewer's installed ruby version.

Once you're happy with your submission, you can send it back in one of two formats, as a git bundle or as a zip file.

To create the git bundle simply execute:

```bash
cd boxing-kata
git bundle create boxing-kata.bundle <YOUR BRANCH NAME HERE>
```

This will create a `.bundle` file which contains the entire git repository in binary form, so you can easily send it as an attachment.  Alternately, you could send the project as a zip file.

Example Input File
------------------
The input file is a CSV file which contains the following fields:

```
id,name,brush_color,primary_insured_id,contract_effective_date
2,Anakin,blue,,2018-01-01
3,Padme,pink,2,,
4,Luke,blue,2,,
5,Leia,green,2,,
6,Ben,green,2,,
```

Currently, we only support one family per configuration file.

User Stories
--------------

**Importing family preferences**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to view family member brush preferences_<br>

To begin the boxing process the shipping manager must import family data.  When the system receives the input file, then the brush color counts will be displayed in the format below.

```
BRUSH PREFERENCES
blue: 2
green: 2
pink: 1
```
**Starter boxes**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to fill starter boxes_<br>

Now that member data has been imported, the shipping manager can begin filling boxes. Each family member will receive one brush and one replacement head. Both the brush and the replacement head must be in the family member's preferred color. A starter box can contain a maximum of 2 brushes and 2 replacement heads in any combination of colors.

When the shipping manager presses the starter boxes button, then a number of boxes are output.  Using the brush preferences example above, box output will be generated in the following format:

```
STARTER BOX
2 blue brushes
2 blue replacement heads

STARTER BOX
2 green brushes
2 green replacement heads

STARTER BOX
1 pink brush
1 pink replacement head
```

If no family preferences have been entered then the message `NO STARTER BOXES GENERATED` should be displayed.

**Refills**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to fill refill boxes_<br>

A family should receive refill boxes with a replacement brush head in each member's preferred color. A refill box can contain a maximum of 4 replacement heads. When the shipping manager presses the refill boxes button, then a number of refill boxes are output.  Using the brush preferences example above, box output will be generated in the following format:

```
REFILL BOX
2 blue replacement heads
2 green replacement heads

REFILL BOX
1 pink replacement head
```

If no starter boxes have been generated, then the message `PLEASE GENERATE STARTER BOXES FIRST` should be displayed.

**Scheduling**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to schedule boxes for shipping_<br>

Members should receive perks throughout the length of their contract (1 year).  The shipping date is based on the contract effective date of the primary insured family member.  Starter boxes should be scheduled on the contract effective date.  Refills are scheduled every 90 days after that for the remainder of the year. When boxes are generated then each box should have a line appended with its scheduled ship date(s).

Example for a starter box:
```
STARTER BOX
2 green brushes
2 green replacement head
Schedule: 2018-01-01
```

Example for a refill box:
```
REFILL BOX
1 pink replacement head
Schedule: 2018-04-01, 2018-06-30, 2018-09-28, 2018-12-27
```

**Mail Class**

_As a Beam shipping manager_<br>
_In order to save money on shipping_<br>
_I want to determine mail class_<br>

In order to manage shipping costs and to deliver perks quickly we want to determine the mail class of boxes. Mail class is based on the weight of the box. Boxes that weigh 16oz or more have a class of "priority".  Boxes that weigh less than 16oz have a mail class of "first". Weight is calculated as such: 1 brush weighs 9oz, and 1 replacement head weighs 1oz. When boxes are generated, then each box should have a line appended with its mail class.

Example for a starter box:
```
STARTER BOX
2 green brushes
2 green replacement head
Schedule: 2018-01-01
Mail class: priority
```

Example for a refill box:
```
REFILL BOX
1 pink replacement head
Schedule: 2018-04-01, 2018-06-30, 2018-09-28, 2018-12-27
Mail class: first
```

**Paste Kits**

_As a Beam shipping manager_<br>
_In order to ship paste kits_<br>
_I want to add paste kits to the boxes_<br>

For each brush or replacement head that is shipped a paste kit is also shipped which contains toothpaste and floss. A paste kit weighs 7.6 oz which will impact on the mail class choice.

Example for a starter box:
```
STARTER BOX
1 pink brush
1 pink replacement head
1 paste kit
Schedule: 2018-01-01
Mail class: priority
```

Example for a refill box:
```
REFILL BOX
1 pink replacement head
1 paste kit
Schedule: 2018-04-01, 2018-06-30, 2018-09-28, 2018-12-27
Mail class: first
```
