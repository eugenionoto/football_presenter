# theScore "the Rush" Interview Challenge
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

### Why a take-home challenge?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

### A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (like Elixir/Phoenix, Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

### Challenge Background
We have sets of records representing football players' rushing statistics. All records have the following attributes:
* `Player` (Player's name)
* `Team` (Player's team abbreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

In this repo is a sample data file [`rushing.json`](/rushing.json).

##### Challenge Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of [`rushing.json`](/rushing.json)
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted data as a CSV, as well as a filtered subset
    
2. The system should be able to potentially support larger sets of data on the order of 10k records.

3. Update the section `Installation and running this solution` in the README file explaining how to run your code

### Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

### Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

### Installation and running this solution
 requerements:
	ruby 2.5.7
	mysql database
	
 steps
   bundle install
   db:create db:migrate db:seed
   rails s
   
   the app will then run on 127.0.0.1:3000
   
### About the solution
  1.1 Create a webpage which displays a table with the contents of [`rushing.json`]
  Since we are supposed to deal with a larger set of data I decided to add the data in a database and run appropriate queries. I strongly believe that even when getting the data from an API, a file or a db we should not request more data than necessary and then filter or sort but request the appropriate data.
  To avoid getting too much data I with went with db_search.rb (parent) and footbal_player_search.rb . The first is to avoid code duplication when future expansions come into play such as basball players ans the secon will be specific to the football player model. Those wil create a paginated query so we cannot blow the memory and we can render fast even if the original set would include too much data. Another choice that I made was to fill in the ATTRIBUTES_TO_DISPLAY constant all the attributes that we want to show. other attributes can be added to the model and should be in PRIVATE_ATTRS
  
  1.2 The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
  Also in that case we will use the help of footbal_player_search.rb. In the football_player.rb model we have the following constant: SORTABLE_PARAMS.any attribute in that array will be automatically picked by the view and decorated with some class and transformed into a link. On clicking on that link we will sort the data based on the attribute name. For instance if you add teams to that list and reload the page, we will be able to sort by teams without touching anything else. Tor the _Total Rushing Touchdowns_ the sorting is a bit delicate because of the potencial presence of the "T". That column is then a string and 9 will be considered greater that 81. To solve that I added a longest_rush_sortable_field which I preprocess before adding the record in the database and it will contain the information that I can use to sort. I added that column to the PRIVATE_ATTRS. Now my code will automatically use a sortable_field in place of the field itself for order when such a field is present. so if we added a name_sortable_fild column in the model and database containnig "lasname firstname" and add the name field to the SORTABLE_PARAMS, we could display the player names as they are now, but sort them by last name.
  
  1.3 The user should be able to filter by the player's name
  Nothing super fancy here, db_search.rb (parent) and footbal_player_search.rb include in the db query a search field which uses an OR clause on all the filters present in the SEARCHABLE_PARAMS constant in the football_players model. Adding team in that constant will automatically update the placeholder in the search field and search in the name or in the team.
  
  1.4 The user should be able to download the sorted data as a CSV, as well as a filtered subset
  
  Here I load the records using the db_search.rb (parent) and footbal_player_search.rb so we will get the same search and sort params, but we do not want to export only one page so I loop through all the pages. This mechanism will allow me to export even a large amount of data without blowing the memory since we load 200 records at the time and then release the memory.
