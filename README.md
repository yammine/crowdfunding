Fund.sy
=======

Purpose
-------
Just a run of the mill crowdfunding app. Users create campaigns, other users can pledge $X to the campaign. Campaigns have a variable number of reward levels (think kickstarter). 

Notable features
----------------
* Using statemachine for managing draft/published/cancelled campaigns as well as paid/refunded pledges.
* Using decorator/service objects
* User authentication from scratch


TODO
----
* Style the site beyond bootstrap
* Implement Stripe for payment processing
* Switch to Devise for user auth possibly