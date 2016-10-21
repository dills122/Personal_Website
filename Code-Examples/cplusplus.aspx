<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cplusplus.aspx.cs" Inherits="cplusplus" MasterPageFile="~/MasterPage.master" %>


<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <!-- Adding Code coloring to my code examples -->
    <link rel="stylesheet" href="../css/foundation.css">
    <script src="../js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <!-- Bootstrap addtions -->
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/jquery-3.1.1.min.js"></script>

    <div class="container">
        <div class="navbar navbar-default" id="mainNavBar">
            <div class=" container-fluid">
                <ul class="nav navbar-nav">
                    <li><a href="javascript:void(0)" onclick="document.getElementById('num-of-paths').scrollIntoView(true);">Number of Paths</a></li>
                    <li><a href="javascript:void(0)" onclick="document.getElementById('post-fix').scrollIntoView(true);">Post Fix Expressions</a></li>
                    <li><a href="javascript:void(0)" onclick="document.getElementById('BST').scrollIntoView(true);">Binary Search Tree</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div id="num-of-paths">
        <div>
            <h3>Number of available paths</h3>
            <br />
            <h4>Description: </h4>
            <p style="margin-right: 2cm; font-size: medium">
                This program ues <code>recursion</code> to calculate the number of available paths when two numbers are inputted.
            </p>
        </div>
        <br />
        <div>
            <pre class="pre-scrollable" style="max-height: 800px"><code >

         /**
*proj7.cpp

*
*CMPSC122 Summer 2015
*
*
*Due Time: 11:55PM, Saturday, 13th of June, 2015
*
*Time of Last Modification: 8:00PM, Saturday, 13th of June, 2015
*
* Input: north - the number of spaces north point B is from A, east - the number of spaces east point B is from A
max - maximum number of spaces allowed to ensure that the program doesn't crash, intialx and intialy - constant starting point
input - the char value that the user inputs into to check if the user would like to repeat the loop and enter new numbers

Output: paths - the number of paths avaliable to move from point A to B. This is calculated by the recursive function numPaths.

*Academic Integrity Affidavit:
*I certify that, this program code is my work. Others may have
assisted me with planning and concepts, but the code was written
solely, by me.
I understand that submitting code which is totally or partially
the product of other individuals is a violation of the Academic
Integrity Policy and accepted ethical precepts. Falsified
execution results are also results of improper activities. Such
violations may result in zero credit for the assignment, reduced
credit for the assignment, or course failure.
*/




#include <iostream>
#include "timer.h"

using namespace std;
const int max = 16;
const int intialx = 0, intialy = 0;
int numPaths( int x, int y);

int main()
{
	//Time object
	Timer t;
	
	int north = 0, east = 0;
	while (true)
	{
		cout << "How many points north of A is B? ";
		cin >> north;
		cout << endl << "How many points east of A is B? ";
		cin >> east;
		cout << endl;

		//Checks to make sure that the inputted numbers don't exceed 16
		if (north > max && east > max)
		{
			cout << "You entered to high of a number" << endl;
			exit(1);
		}
		t.start();
		int paths = numPaths(north, east);
		t.stop();
		cout << "Number of paths avaliable is " << paths << endl;
		t.show();
		cout << endl;

		//checks to see if the user wants to enter new numbers
		char input;
		cout << "Would you like to try again? " << "Press y to repeat or any other key to exit" << endl;
		cin >> input;
		tolower(input);
		if (input != 'y')
		{
			exit(1);
		}
	}
}

//function that calculates the number of paths recursively 
int numPaths(int x, int y)
{
	//check to make sure the user didn't input the starting position 
	if (x == intialx && y == intialy)
	{
		return 0;
	}
	//if the path only involves vertical or horizontal movement
	else if (x == intialx || y == intialy)
	{
		return 1;
	}
	//returns all of the other possible paths 
	else
	{
		return numPaths(x - 1, y) + numPaths(x, y - 1);
	}
	

}

/*  OUTPUT:

How many points north of A is B? 2

How many points east of A is B? 3

Number of paths avaliable is 10
Process Timer
-------------------------------
Elapsed Time   : 0.001s

Would you like to try again? Press y to repeat or any other key to exit
y
How many points north of A is B? 0

How many points east of A is B? 0

Number of paths avaliable is 0
Process Timer
-------------------------------
Elapsed Time   : 0.001s

Would you like to try again? Press y to repeat or any other key to exit
y
How many points north of A is B? 16

How many points east of A is B? 16

Number of paths avaliable is 601080390
Process Timer
-------------------------------
Elapsed Time   : 22.224s

Would you like to try again? Press y to repeat or any other key to exit
y
How many points north of A is B? 12

How many points east of A is B? 14

Number of paths avaliable is 9657700
Process Timer
-------------------------------
Elapsed Time   : 0.355s

Would you like to try again? Press y to repeat or any other key to exit


*/

         </code></pre>
        </div>
    </div>


    <br />
    <br />
    <br />

    <div id="post-fix">
        <div>
            <h3>Number of available paths</h3>
            <br />
            <h4>Description: </h4>
            <p style="margin-right: 2cm; font-size: medium">
                This program ues <code>recursion</code> to calculate the number of available paths when two numbers are inputted.
            </p>
        </div>
        <br />
        <div>
            <pre class="pre-scrollable" style="max-height: 800px"><code >
                /**
*proj5.cpp
*
*Name: Dylan Steele
*
*PSU ID: 967460512
*
*CMPSC122 Summer 2015
*
*
*Due Time: 11:55PM, Sun, 7th of June, 2015
*
*Time of Last Modification: 2:30PM, Wednesday, 27th of May, 2015
*
*Input: Expression - array of max length that holds the inputted expression, input - char that holds an inputted character to test if the loop will run again
myStack - the stack used to store the data while computing, operandOne - the converted value of the first number to be computed, 
operandTwo - the converted value of the second number to be computed, *tempPtr - pointer that points to temp for the conversion of the numbers
temp - holds the converted numerical value, ans - the operatered value from performOperation function

*Academic Integrity Affidavit:
*I certify that, this program code is my work. Others may have
assisted me with planning and concepts, but the code was written
solely, by me.
I understand that submitting code which is totally or partially
the product of other individuals is a violation of the Academic
Integrity Policy and accepted ethical precepts. Falsified
execution results are also results of improper activities. Such
violations may result in zero credit for the assignment, reduced
credit for the assignment, or course failure.
*/


#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <stack>
#include <string.h>

using namespace std;

int performOperation(int operand1, int operand2, char operate);

int main()
{
	stack<int> myStack;

	const int maxLength = 20;
	


	while (true)
	{
		char expression[maxLength], input;
		int operandOne, operandTwo, 
			i = 0, 
			temp, *tempPtr = &temp, 
			opnum = 0;

		cout << "Please enter a postfix expression" << endl << "Example 5 4 + 6 7 * :" << endl << "Please include : at the end of your expression" << endl;
		//reads the user expression up to maxlength and terminates at the semicolon
		cin.getline(expression, maxLength, ':');

		int length = strlen(expression) -1;

		cout << "The expression you enter is " << endl;
		for (int i = 0; i < length; i++)
		{
			//outputs the users entered expression
			cout << expression[i];
			
		}
		cout << endl;

		cout << "The expression is " << length << " character long" << endl;
		//a loop that runs through as many loops as there are character in the array
		for (int i = 0; i < (length); i++)
		{
			cout << "Character number " << i << " is " << expression[i] << endl;
			//checks if the current character is a number
			if (isdigit(expression[i]))
			{
				//converts the digit to an int 
				*tempPtr = expression[i] - '0';
				//pushes the newly converted value to the top
				myStack.push(temp); 
				*tempPtr = 0;
				cout << "Push " << expression[i] << " Top After pushing " << myStack.top() << endl;
			}
			//checks if the terminating character : is present
			else if (expression[i] == ':')
			{
				exit(1);
			}
			//checks if the current character is an operator
			else if (expression[i] == '+' || expression[i] == '-' || expression[i] == '*' || expression[i] == '/')
			{
				cout << "Operator number " << opnum << " is " << expression[i] <<  endl;
				//sets operandOne equal to the current top
				operandOne = myStack.top();
				cout << "Pop " << myStack.top() << endl;
				//removes current top value
				myStack.pop();
				cout << "Top after poping " << myStack.top() << endl;
				//sets operandTwo equal to the current top
				operandTwo = myStack.top();
				cout << "Pop " << myStack.top() << endl;
				//removes top value
				myStack.pop();
				//performs the operation with the two operators in operandOne and operandTwo and the operator stored at expression[i]
				myStack.push(performOperation(operandOne, operandTwo, expression[i]));
				cout << "Top after operation " << myStack.top() << endl;

				//counts the number of operators
				opnum++;

			}
			i++;
		}
		//outputs the final answer 
		cout << "The answer to this postfix problem is " << myStack.top() << endl;
		//checks if the user would like to compute another expression
		cout << "Would you like to enter another postfix expression to evaluate? Enter y for yes" << endl;
		cin >> input;
		input = tolower(input);
		if (input != 'y')
		{
			break;
		}
	
	
	} 
	//removes the final value in the stack in case the user runs the program over again to compute another expression
	myStack.pop();

	return 0;
}

//a function that passes in the operator and the two numbers to be operated on
int performOperation(int operand1, int operand2, char operate)
{
	int ans;
	//uses a switch statement to perform the correct operation
	switch (operate) {
	case '+':
		ans = operand2 + operand1;
		break;
	case '-':
		ans = operand2 - operand1;
		break;
	case '*':
		ans = operand2 * operand1;
		break;
	case '/':
		ans = operand2 / operand1;
		break;
	}
	//returns the answer after the specific operation is processed
	return ans;
}

/*
Please enter a postfix expression
Example 5 4 + 6 7 * :
Please include : at the end of your expression
5 4 - 6 + :
The expression you enter is
5 4 - 6 +
The expression is 9 character long
Character number 0 is 5
Push 5 Top After pushing 5
Character number 2 is 4
Push 4 Top After pushing 4
Character number 4 is -
Operator number 0 is -
Pop 4
Top after poping 5
Pop 5
Top after operation 1
Character number 6 is 6
Push 6 Top After pushing 6
Character number 8 is +
Operator number 1 is +
Pop 6
Top after poping 1
Pop 1
Top after operation 7
The answer to this postfix problem is 7
Would you like to enter another postfix expression to evaluate? Enter y for yes


*/



                </code>
                </pre>

        </div>

    </div>

    <br />
    <br />
    <br />

    <div id="BST">
        <div>
            <h3>Binary Search Tree</h3>
            <br />
            <h4>Description: </h4>
            <p style="margin-right: 2cm; font-size: medium">
                Example of a binary search tree I created for a project.
            </p>
        </div>
        <br />
        <div>
            <pre class="pre-scrollable" style="max-height: 800px"><code >
               
#pragma once
#include <string>

using namespace std;



class BST
{
public:

	
	//checks if the binary tree is empty
	bool empty() const
	{
		return myRoot == 0;
	}
	
	bool search(const string & item) const
	{
		BinNodePointer locptr = myRoot;
		bool found = false;
		while (!found && locptr != 0)
		{
			if (item < locptr->data)
			{
				locptr - locptr->left;
			}
			else if (locptr->data < item)
			{
				locptr = locptr->right;
			}
			else
			{
				found = true;
			}
			return found;
		}
	}
	void insert(const string & item)
	{
		BinNodePointer locptr = myRoot, parent = 0;
		bool found = false;
		while (!found && locptr != 0)
		{
			parent = locptr;
			if (item < locptr->data)
			{
				locptr = locptr->left;
			}
			else if (item > locptr->data)
			{
				locptr = locptr->right;
			}
			else
			{
				found = true;
			}
		}
		if (!found)
		{
			locptr = new BinNode(item);
			if (parent == 0)
			{
				myRoot = locptr;
				//adds one to the counter for the newly inserted node
				myRoot->counter = 1;

			}
			else if (item < parent->data)
			{
				parent->left = locptr;
				//adds one to the counter for the newly inserted node
				locptr->counter = 1;
			}
			else
			{
				parent->right = locptr;
				//adds one to the counter for the newly inserted node
				locptr->counter = 1;
			}
		}
		else
		{
			//if the word already exists then the counter on the specific node is just incremented by one
			locptr->counter++;

		}
	}
	//outputs the binary search tree
	void PrintTree(ofstream& out)
	{
		//function in the private section
		PrintTreeAux(out, myRoot);
	}
	
	
private:
	class BinNode
	{
	public:
		string data;
		//added the counter to the Binary tree class rather than creating its own class
		int counter;
		BinNode * left;
		BinNode * right;

		BinNode()
			:left(0), right(0),counter(0)
		{}
		BinNode(string item)
			:data(item),left(0),right(0),counter(1)
		{}
	};
	typedef BinNode *BinNodePointer;

	void PrintTreeAux(ofstream & out, BinNodePointer subtreeRoot) const
	{
		if (subtreeRoot != NULL)
		{
			//in order traversal for printing out the tree
			PrintTreeAux(out, subtreeRoot->left);
			out << subtreeRoot->data << "   " << subtreeRoot->counter << endl;
			PrintTreeAux(out, subtreeRoot->right);
		}
	}

	//Data Members
	BinNodePointer myRoot;
	
};


                </code>
                </pre>

        </div>

    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>


