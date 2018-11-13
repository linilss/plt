int main()
{
    //homework.push_back(x);
	//vec_sz size = homework.size();
    //median = true ? false : true;
    
    median = size % 2 == 0 ? 
                    (homework[mid] + homework[mid-1]) / 2 :
                    homework[mid];
}


