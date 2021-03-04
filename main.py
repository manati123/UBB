import saving
from random import randrange
from domain import Environment, DroneMap, Drone, MOVE_AUTOMATICALLY, PLAY_BY_HAND
from gui import GUI
from controller import Controller


def main():
    #print("hbhsdkfsdkjbf")
    env = Environment()
    env.generate_random_map()
    saving.save_environment(env, "test2.map")

    rows = env.get_rows()
    columns = env.get_columns()

    x = randrange(0, rows)
    y = randrange(0, columns)
    while env.detect_wall(x, y):
        x = randrange(0, rows)
        y = randrange(0, columns)
    drone = Drone(x, y)
    drone_map = DroneMap(rows, columns)
    service = Controller(env, drone_map, drone)
    gui = GUI(service, MOVE_AUTOMATICALLY)
    gui.start()


if __name__ == "__main__":
    main()
