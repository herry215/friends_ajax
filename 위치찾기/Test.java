package study;

import java.util.*;

public class Test {
	
	public int solution(int[][] map) {
		int answer=0;
		boolean[][] visit = new boolean[map.length][map[0].length];
		for(int i = 0; i < map.length; i++){
			for(int j = 0; j < map[0].length; j++){
				if(0 < map[i][j] && !visit[i][j]){
					System.out.println(answer);
					answer = Math.max(areaDFS(map, visit, i, j), answer);
				}
			}
		}
		return answer;


	}
	public int areaDFS(int[][] map, boolean[][] visited, int startx, int starty){

		int n = map.length;
		int m = map[0].length;
		
		int kkk = 0;

		Stack <int[]> stack = new Stack<>();
		stack.push(new int[]{startx,starty});
		visited[startx][starty] = true;

		int[] dx = {-1,1,0,0};
		int[] dy = {0,0,-1,1};

		while(!stack.isEmpty()){
			int[] current =stack.pop();
				
				for(int i = 0; i < 4; i++){
				int nx = dx[i] + current[0];
				int ny = dy[i] + current[1];

				if(n > nx && 0 <= nx && m > ny && 0 <= ny && map[nx][ny] == 1 && !visited[nx][ny]){
					stack.push(new int[]{nx,ny});
					visited[nx][ny] = true;
					kkk++;
				}
			}
		}

	return kkk;
	}
}
