### Social Network Analysis: ERGM analyses of network structure

The purpose of this project is to get experience with exponential random graph modelling of network structure, both in thinking and in practise.

**Context:**     
      
Friendship networks in school are typically highly gender segregated, highly clustered, and highly reciprocated. What is more, the corresponding actor-level “behavioural network mechanisms” of gender homophily (nominating same-gender persons as friends), reciprocation (sending friendship nominations to those people one receives one from), and transitive closure (nominating somebody as a friend who is a friend of a friend) are confounded.

Questions that are discussed in the project are:

- Why does the mechanism of gender homophily may create networks in which there is a high degree of reciprocity and transitivity, even if no explicit mechanisms of reciprocation and transitive closure operate?
- Why is the opposite not generally true, i.e., why the mechanisms of reciprocation or transitive closure do not generally create networks which are gender segregated?
            
**Empirical Data:**       
            
The data set I used is collected as part of Andrea Knecht’s PhD study at Utrecht University. It consists of information about first-year students in Dutch secondary schools (aged 12-13) in the school year 2003-04. Specifically, the first wave of the SNA2020-24 network data set is picked for analysis. The data were obtained as sociocentric networks within the school class boundary. And the network is not entirely segregated. There are some cross-gender ties to avoid degeneracy.       
         
**Models:**             

Three exponential random graph models are applied to the data:       
1. One model that simultaneously assesses overall tie creation tendencies, reciprocation tendencies, gender homophily tendencies and transitivity tendencies.   
2. A second model where reciprocity and transitivity are dropped, while all the other parameters are retained.
3. A third model where, conversely, gender homophily is dropped from the full model but all the other parameters are retained.       
        
Results and interpretations are displayed in the report file.        
