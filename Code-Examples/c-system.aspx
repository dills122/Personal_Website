<%@ Page Language="C#" AutoEventWireup="true" CodeFile="c-system.aspx.cs" Inherits="Csystemaspx" MasterPageFile="~/MasterPage.master" %>


<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <div>
        <h3>Multi-Threaded Word Counter</h3>
        <br />
        <h4>Description: </h4>
        <p style="margin-right: 2cm; font-size:medium">
            This program takes advantage of the Unix system's functions as in <code> pipes </code>and <code>processes</code>. It divides its file that is to be 
            counted into n smaller chuncks and creates n-1 <code>processes</code> to handle the counting of the words.
            After a process has finished computing its word count, it will start to send back its completed list of words and 
            there number of occurances through <code>pipes</code>. Finally the main process will recieve the data through <code>pipes</code> and combines
            each processes data into a final consolidated file of words and there number of occurances in alphabetical order.
        </p>
    </div>
    <br />
    <pre class="pre-scrollable" style="max-height: 800px"><code >
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <string.h>

#define MAX 1024

typedef int bool;
enum { false, true };

struct word
{
	char* word;
	int count;
	struct word* next;
};


//---------------------------------
//--Function for qsort comparison--
//--------------------------------- 
int cstring_cmp(const void *a, const void *b)
{
    const char **ia = (const char **)a;
    const char **ib = (const char **)b;
    return strcmp(*ia, *ib);
        /* strcmp functions works exactly as expected from
        comparison function */
}


int main(int argc, char* argv[]) {
        //create clock_t varibables to record run-time
        clock_t begin, end;
        //double to hold value of run-time
        double run_time;
        //set beginning time
        begin = clock();

#ifdef DEBUG
        printf("\n--The program is starting--\n\n");
#endif



        //create file objects for opening file
        FILE *ifp, *ofp;
        //create strings holding location of the intput and output files
        char *file, *temp, *out, *run_ti;
	//create int to hold number of children to use
	int n;
	
        if(argc == 2) {
                file = argv[1];
                out = "word_count.txt";
                run_ti = "run_time.txt";
        	n = 2;
	}
        else if(argc == 3) {
                file = argv[1];
                out = "word_count.txt";//argv[2];
                run_ti = "run_time.txt";
		n = atoi(argv[2]);
        }
        else if(argc == 4) {
                file = argv[1];
                out = argv[2];
                run_ti = argv[3];
		n = 2;
        }
	else if(argc == 5) {
		file = argv[1];
		out = argv[2];
		run_ti = argv[3];
		n = atoi(argv[4]);
	}
        else {//solve errors
                printf("Enter the name of a local .txt file to run word count on: ");
                scanf("%s", file);
                printf("Enter the name of the output file to write word count to: ");
                scanf("%s", out);
                printf("Enter the name of the output file to write the run-time to: ");
                scanf("%s", run_ti);
		printf("Enter the number of children processes to use: ");
		scanf("%d", n);
        }
        temp = "temp.txt";

        char buff[255];

        //open the file streams to read and write to the files
        ifp = fopen(file, "r");
        ofp = fopen(temp, "w+");

#ifdef DEBUG    
        printf("--File Streams opened--\n\n--Now removing special chaacters and making all letters lowercase--\n\n");
#endif

        //remove any special characters and turn all capitals to lower case

        int c;
        while((c = getc(ifp)) != EOF)
                if(isalpha(c) || isspace(c) || isdigit(c))
                        fputc(tolower(c), ofp);

        fclose(ofp);//close stream to open with new permission

        ofp = fopen(temp, "r");//reopen stream


        bool null_ele;
        int size = 0;

#ifdef DEBUG
        printf("--Special characters removed and all letters now lowercase--\n - now reading words into unsorted array -\n\n");
#endif

        //get the size of the file to be read in
        while(fscanf(ofp, "%s", buff) != EOF)   size++;
        //create array to allow sorting of words
        char** raw_words = malloc(size*sizeof(char*));
        //create iterator int to populate values of raw_words
        int i = 0;

        fclose(ofp);//close stream to open with new permission
        ofp = fopen(temp, "r");//reopen stream

        //copy each word from the file into an element of the array
//	printf("Array of raw words--------\n");

        while(fscanf(ofp, "%s", buff) != EOF){
                raw_words[i++] = strdup(buff);
//		printf("%s\t", raw_words[i-1]);
	}
//	printf("\n--------------------------\n");

#ifdef DEBUG    
        printf("--All words read into array--\n - now sorting the array of words -\n\n");
#endif

        //sort array of words
        qsort(raw_words, size, sizeof(char*), cstring_cmp);

#ifdef DEBUG
        printf("--Array is now sorted--\n - now adding each element to the list and counting # of occurences -\n\n");
#endif
	
	int pipes[n-1];//file descriptor for the pipe
	int fd[2];


	pid_t pid, child_pid;//process_id and wait_pid	
	
	pid = getpid();
	
	
//	printf("The parent p_id is: %ld\n", (long)getpid());
	int start_index, range, remain;
	remain = size%n;
	range = size/n;
	//create n_children

	for(i = 1; i < n; i++){
	   start_index = remain + (range)*i;

	   if((pipe(fd)) < 0){
		//failure in creating pipe
		perror("pipe error\n");
		exit(1);
	   }

	   pipes[i-1] = fd[0];

	   if ((pid = fork()) < 0) {
	       //failure in creating a child
               perror ("fork error\n");
       	       exit(2);
       	   }
	   
           if(pid == 0){
	       close(fd[0]);
               break;
	   }
	   else
		close(fd[1]);
		
	}

	//break up and have each thread read part of the array
	int j, count, end_range;
        struct word *head, *curr, *temp_pt;
        curr = head = (struct word*)malloc(sizeof(struct word));
	if(pid != 0)
	{
		start_index = 0;
		range += remain;
	}
        end_range = start_index + range;

//        printf("I'm counting my part - the process id is: %ld\n", (long)getpid());

	
        
        for(i = start_index; i < end_range; i++)
        {
	        count = 1;
                for(j = i+1; j < end_range; j++)
                {
	                //printf("j:%s v k:%s\n", raw_words[j], raw_words[k]);
			if(strcmp(raw_words[i], raw_words[j]) == 0)
                        {
	                        count++;
                        //      free(raw_words[k]);
                        }
                        else
                                break;
                 }

//                 printf("%ld: Count: %d Word: %s\n", (long)getpid(), count, raw_words[i]);
                 
		 if(count == 0)
			break;
		 else{
                 	temp_pt = (struct word*)malloc(sizeof(struct word));
		 
	  	 	temp_pt->word = strdup(raw_words[i]);
                 	temp_pt->count = count;
                 	temp_pt->next = NULL;
                 	curr->next = temp_pt;
		 }
		 i = j-1;
		 curr = curr->next;
        }
	int c_bytes, w_bytes;
		
	if(pid == 0 )
	{
		//is child
//		printf("I'm a child and the process id is: %ld\n", (long)getpid());
	
	
		//THIS is the odd part - needed to set curr = head->next, if set to head the first value
		//is "a" and has an obscene count# (e.g. 6356214)
		//making this change in the parent and child when traversing the list seems to solve the issue
		curr = head->next;
		char count[MAX];
		
		while(curr != NULL)
		{
			char message[strlen(curr->word)+1];
                	//sprintf(count_t, "%04d", curr->count);
			
			sprintf(message, "%s\n", curr->word); 
			sprintf(count, "%d\n", curr->count);
//			printf("%ld - Writing -- Count:\"%d\" Word: \"%s\"\n", (long)getpid(), curr->count, curr->word);
			c_bytes = write(fd[1], count, (strlen(count)));
			w_bytes = write(fd[1], message, (strlen(message)));
//			printf("%ld - Wrote %d bytes to pipe.\n", (long)getpid(), (c_bytes + w_bytes));
		//	printf("Count:\"%s\" #bytes:%d Word:\"%s\" #bytes:%d\n", count, c_bytes, curr->word, w_bytes); 
			curr = curr->next;
		}
		//child has gone through it's part of the array
		close(fd[1]);
		curr = head;
		while(curr != NULL)
		{
			head = curr->next;
			free(curr);
			curr = head;
		}

	}
	else{
		//is parent
//		printf("Waiting\n");
		wait(NULL);

//	        printf("Done waiting - I'm the parent and the process id is: %ld\n", (long)getpid());

		


		char w_count[MAX], word[MAX];
		char *word_pt;
		int wcount;//, c_read, m_read, j;
		FILE *stream;
		for(i = 0; i < n-1; i++){
			stream = fdopen(pipes[i], "r");
         
			while (1) 
			{
				//Clearing the message buffer
                	    	memset (w_count, 0, sizeof(w_count));
				memset (word, 0, sizeof(word));
                	    	//Reading message from the pipe

				//Read until there is nothing left in the pipe
				if(fgets(w_count, MAX, stream)==NULL)
					break;
				if(fgets(word, MAX, stream)==NULL)
					break;

				c_bytes = strlen(w_count); //read count
				w_bytes = strlen(word); //read word
                    	
			//	printf("c_read=%d w_read=%d\n", c_bytes, w_bytes);
			//	if(c_bytes == 0 || w_bytes == 0) //if read returns 0 to either break
                	//        	break;
		
				//below snippet was pulled from stackoverflow and replaces '\n' with '\0'
				char *pos;
				if((pos = strchr(word, '\n')) != NULL)
					*pos = '\0';				

				wcount = atoi(w_count);
 //                   		printf("The count is %d\t", wcount);

 //                   		printf("for the word \"%s\"\n", word);

				curr = head->next;	


				//now search through the parent linked list for the word
				//add to list if not already in it

				int comp;
				

				
				while(curr != NULL)
				{
				//	printf("Current word in list:%s with count:%d", curr->word, curr->count);
					word_pt = curr->word;

					//Prevents error from happening in strcmp
					if(curr->count == 0)
					{
                                                break;
					}
					else
						comp = strcmp(word_pt, word);
				//	printf("\tcomp:%d\n", comp);
					//if the words are the same increment the word's count
					if(comp == 0)
					{
						curr->count+=wcount;
						break;
					}
					//add the a new word node in front of current
					//this is to keep alphabatization
					else if(comp > 0)
					{
						temp_pt = (struct word*)malloc(sizeof(struct word));
						temp_pt->word = strdup(word);
						temp_pt->count = wcount;
						temp_pt->next = curr;
						curr = temp_pt;
					//	free(temp_pt);
						break;
					}
					//if at the end of the list, add the new word node to the end
					else if(curr->next == NULL)
					{
						temp_pt = (struct word*)malloc(sizeof(struct word));
                                                temp_pt->word = strdup(word);
                                                temp_pt->count = wcount;
                                                temp_pt->next = NULL;
                                                curr->next = temp_pt;
                                               // free(temp_pt);
						break;
						
					}
					curr = curr->next;
					
				}
				//free(temp_pt);


            		}
            		close(pipes[i]);
			curr = head->next;

			FILE *fp = fopen(out, "w+");
		        struct word *ptr = head->next;
//		        fprintf(fp, "Word count for file: %s\n", file);
//		        fprintf(fp, "-----------------------------------\n");
		        while(ptr != NULL)
		        {
		                fprintf(fp, "%s, %d\n", ptr->word, ptr->count);
		                ptr = ptr->next;
		        }
		        fclose(fp);
			printf("List printed to %s", out);
/*
			printf("The list is --------------------\n");
			while(curr != NULL)
			{
				printf("Element:%s Count:%d\n", curr->word, curr->count);
				curr = curr->next;
			}
*/			//free the memory
			curr = head;
			while(curr != NULL)
			{
				curr = head->next;
				free(head);
				head = curr;
			}
			
		}
		//close file pipes
		close(ifp);
		close(ofp);

		free(raw_words);

		//set end of run-time
        	end = clock();
        	//calculate run-time
        	run_time = (double)(end - begin) / CLOCKS_PER_SEC;
		
		ofp = fopen(run_ti, "a");
        	fprintf(ofp, "--Program completed execution on file: %s in %G seconds\n", file, run_time);
        	fclose(ofp);

            	//wait(NULL);


	}
	
	
	

	return 0;
}

    </code>
        </pre>
</asp:Content>
