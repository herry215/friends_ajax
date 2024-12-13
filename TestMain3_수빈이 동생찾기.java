import java.util.*;

public class TestMain3 {
    public static void main(String[] args) {
        int n = 5;  //수빈이의 위치
        int k = 17;  //동생의 위치

        Queue<int[]> que=new LinkedList<>();
        que.add(new int[]{n, 0});  // (동생찾기위한 값, 몇번거쳐서 가는지.)
        
        // Set<Integer> set = new set<Integer>();
        // set.add(n);

        while (!que.isEmpty()) { //큐가 비어있지 않으면.

            int[] m = que.poll();//큐의 값을 빼서 m에 넣어준다.

            if (m[0] == k) {
                System.out.println("동생찾음 몇번째 ? "+ m[1]);
                break;
            }

            que.add(new int[] { m[0] + 1, m[1] + 1 });
            que.add(new int[] { m[0] - 1, m[1] + 1 });
            que.add(new int[] { m[0] * 2, m[1] + 1 });

        }
    }
}
