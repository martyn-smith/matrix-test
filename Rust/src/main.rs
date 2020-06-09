#[allow(unused_imports)]
use nalgebra::{ArrayStorage, DMatrix, Matrix};
use typenum::U4096;

//type BigMatrix = Matrix<f64, U4096, U4096, ArrayStorage<f64, U4096, U4096>>;

fn main() {
    let x = DMatrix::<f64>::new_random(4096, 4096);
    let y = DMatrix::<f64>::new_random(4096, 4096);
    let _z = x * y;
}

