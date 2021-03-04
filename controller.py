from constants import DIRECTIONS


class Controller:
    def __init__(self, env, drone_map, drone):
        self.__env = env
        self.__drone_map = drone_map
        self.__drone = drone
        self.__gen = None
        self.__visited = None
        self.__mark_detected_walls()

    def __mark_detected_walls(self):
        walls = self.__env.read_udm_sensors(self.__drone.x, self.__drone.y)#the function we got from the teacher
        self.__drone_map.mark_detected_walls(walls, self.__drone.x, self.__drone.y)#marking the detected walls on the drone map using the UDM sensors

    def __dfs(self, x, y, visited_cells, _map):
        visited_cells.add((x, y))  # adding them as a tupple
        for direction in DIRECTIONS:
            x2 = x + direction[0]
            y2 = y + direction[1]
            if 0 <= x2 < self.get_rows() and 0 <= y2 < self.get_columns() and (x2, y2) not in visited_cells and _map[x2][y2] == 0:# problem was: i was not going to
                yield x2, y2                                                                                                #column 0 too... I put < instead of <=
                yield from self.__dfs(x2, y2, visited_cells, _map)
                yield x, y

    def get_rows(self):
        return self.__env.get_rows()

    def get_columns(self):
        return self.__env.get_columns()

    def get_env(self):
        return self.__env

    def get_drone_map(self):
        return self.__drone_map

    def get_drone(self):
        return self.__drone

    def move_dfs(self):
        if self.__gen is None:
            self.__visited_cells = set()#if we've not visited anything we make a set of visited cells
            #I used set to not have duplicated moves

            self.__gen = self.__dfs(self.__drone.x, self.__drone.y, self.__visited_cells,
                                    self.__drone_map.get_surface())#generate moves

        try:
            self.__drone.move(next(self.__gen))#using next because I yield moves instead of returning them
            self.__mark_detected_walls()#mark the walls
            return True
        except StopIteration:#the drone stops when next(self.__gen)) is empty and it throws StopIteration exception
            self.__drone.move((None, None))#stop
            self.__mark_detected_walls()#mark the walls
            return False

    def move_by_user(self, direction):#move by user input
        x = self.__drone.x + DIRECTIONS[direction][0]
        y = self.__drone.y + DIRECTIONS[direction][1]

        if 0 <= x < self.get_rows() and 0 <= y < self.get_columns() and self.__drone_map.get_surface()[x][y] == 0:
            self.__drone.move((x, y))
        self.__mark_detected_walls()
