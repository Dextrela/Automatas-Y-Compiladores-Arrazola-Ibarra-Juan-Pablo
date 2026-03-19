class prueba3 {
    static int calculatePerimeter(int length, int breadth) {
        return 2 * (length + breadth);
    }
    public static void main(String[] args) {

        int length = 10;
        int breadth = 20;

        int perimeter = calculatePerimeter(length, breadth);
        System.out.println("The perimeter of the rectangle is: " + perimeter);
    }
}