import 'package:get/state_manager.dart';

import 'package:dynamic_widget_app_task/models/cart.dart';
import 'package:dynamic_widget_app_task/utils/plant_items.dart';

class CartController extends GetxController {
  RxList<Rx<Cart>> cartProducts = [
    Cart(cartItemId: 1, quantity: 1.obs, plant: PlantItems.plantList[0]).obs,
    // Cart(cartItemId: 2, quantity: 4.obs, plant: PlantItems.plantList[1]).obs,
    // Cart(cartItemId: 3, quantity: 2.obs, plant: PlantItems.plantList[2]).obs,
    // Cart(cartItemId: 4, quantity: 1.obs, plant: PlantItems.plantList[3]).obs,
  ].obs;

  var totalPrice = (PlantItems.plantList[0].prize
      //  + 4 * PlantItems.plantList[1].prize +
      //         2 * PlantItems.plantList[2].prize +
      //         PlantItems.plantList[3].prize
      )
      .obs;

  @override
  void onInit() {
    super.onInit();
    getCartProducts();
  }

  getCartProducts() async {
    //database se call karke lena hai
  }

  addProduct(Cart cart) async {
    cartProducts.add(cart.obs);
    totalPrice.value += cart.plant.prize * cart.quantity.value;
  }

  decreaseProductQuantity(int index) {
    cartProducts[index].value.quantity.value--;
    totalPrice.value -= cartProducts[index].value.plant.prize;
  }

  addProductQuantity(int index) {
    cartProducts[index].value.quantity.value++;
    totalPrice.value += cartProducts[index].value.plant.prize;
  }

  removeProduct(int index) async {
    totalPrice.value -= (cartProducts[index].value.plant.prize *
        cartProducts[index].value.quantity.value);
    cartProducts.removeAt(index).value;
  }

  void checkout() {
    cartProducts.clear();
    totalPrice = 0.0.obs;
  }
}
