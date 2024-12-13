import java.util.*;
//10 1 10 2 1     answeree 6    -https://www.acmicpc.net/problem/5014
class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String s = sc.nextLine();
		String[] arr = s.split(" ");
		sc.close();
		int[] iarr = new int[arr.length];
		for (int i = 0; i < arr.length; i++) {
			iarr[i] = Integer.parseInt(arr[i]);
		}
		int F = iarr[0];
		int S = iarr[1];
		int G = iarr[2];
		int U = iarr[3];
		int D = iarr[4];

		Queue<int[]> que = new LinkedList<>();
		int[] start = { S, 0 };
		que.add(start);
		// que.add(new int[]{S,0});

		boolean[] visited = new boolean[F];
		visited[S - 1] = true;
		boolean is =true;
		while (!que.isEmpty()) {
			int[] m = que.poll();

			if (m[0] == G) {
				is=false;
				System.out.println("도착? " + m[1]);
				break;
			}

			if (0 < m[0] + U && m[0] + U <= F && !visited[m[0] + U - 1]) {
				que.add(new int[] { m[0] + U, m[1] + 1 });
				visited[m[0] + U - 1] = true;
			}
			if (0 < m[0] - D && m[0] - D <= F && !visited[m[0] - D - 1]) {
				que.add(new int[] { m[0] - D, m[1] + 1 });
				visited[m[0] - D - 1] = true;
			}

		}
		if(is){
			System.out.println("use the stairs");
		}
	}
}