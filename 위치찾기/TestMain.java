package study;

public class TestMain {

	public static void main(String[] args) {
		
		int[][] Case= {{1,0,0,0},{0,1,1,0},{1,1,0,0}};
		Test test=new Test();
		if(test.solution(Case)==4) {
			System.out.println("정답입니다");
		}
		else {
			System.out.println("틀렸습니다");
		}
	}
}

