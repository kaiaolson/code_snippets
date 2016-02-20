# Code Snippets

## Prompt
As you learn more and more about web development, you will have more and more snippets of code to build different components of your application. Build a tool in Rails that helps you store code snippets.

You must have test coverage (doesn't have to be a 100%) for creating and updating the snippet kinds and the snippets.

The box must accept markdown. Make sure to have the code highlighted properly depending on the language.

Note: avoid using `type` as a column name in models. More on that will come later. This is why the wireframe uses `Kind`, you can pick another word if you'd like just don't use `type`.  

[Stretch] Make snippets owned by users so a user can create their own snippets. Also add `private` checkbox to the snippet code. If the code snippet is private only the user can see it. If the snippet is not private it means it's public and it will show on the home page listing where it will list all the snippets for all the users.

## Additional Features
1. Users can see a list of the snippets they own.
2. Dynamically generated list of languages that filter the snippets upon click.
3. Display count of each language; if a snippet is private, only adds to the count when the snippet owner is signed in.
4. Pagination and search.
5. Bootstrapped. 
