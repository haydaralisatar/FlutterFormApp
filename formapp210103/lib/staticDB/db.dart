import 'package:formapp210103/Models/Personel.dart';

List<Personel> personels = []; //Liste oluşturduk

class DbHelper {
  //statik veritabanımıza verileri eklemek ve silmek için
  void addPerson(Personel person) {
    //person adında değişken aldık
    personels.add(person); //veriyi ekledik
  }

  void deletePerson(int id) {
    personels.removeAt(id - 1);
  }

  void deleteAll() {
    //tüm kişileri sildik.
    personels.removeRange(0, personels.length);
  }

  List<Personel> getPersonlist() {
    //dışardan listeye ulaştık.
    return personels;
  }
}
