import 'package:flutter/material.dart';
import 'package:formapp210103/Pages/formPage.dart';
import 'package:formapp210103/staticDB/db.dart';
import 'package:formapp210103/Models/Personel.dart';
import 'package:date_time_picker/date_time_picker.dart';

List<Personel> personels = [];
DbHelper db = new DbHelper();

class PersoneList extends StatefulWidget {
  //Statik olmadığı için
  @override
  _PersoneListState createState() => _PersoneListState();
}

class _PersoneListState extends State<PersoneList> {
  @override
  Widget build(BuildContext context) {
    personels = db
        .getPersonlist(); //veritabanından listeyi aldık personels listesine attık.

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personel List"), //üst kısım title verdik.
        ),
        body: getPersonelList(), //personel Listesi widget ımızı çağırdık.
        floatingActionButton: FloatingActionButton(
          //temizle butonu
          onPressed: () {
            //tıklandığında
            db.deleteAll(); //veritabanından tüm kayıtları sildi.
            Navigator.pop(context); //sayfayı kapattı ve
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FormPage())); //Kayıt sayasını açtı
          },
          child: Icon(Icons.clear), //Iconunu belirttik.
        ),
      ),
    );
  }
}

ListView getPersonelList() {
  //Tüm kayıtları getireceğimiz için listView
  return ListView.builder(
      itemCount: personels.length, //liste sayısı
      itemBuilder: (BuildContext context, int position) {
        return Card(
          //Kart şeklinde oluşturduk.
          color: Colors.amberAccent, //rengi
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child:
                  Text(personels[position].nameSurname[0]), //adının ilk harfi
            ),
            title: Text(personels[position].nameSurname +
                    "\n" //başlık kısmına kişinin bilgilerini yazdık
                    +
                    personels[position].phone +
                    "\n" +
                    (DateFormat("dd/MM/yyyy").format(DateTime.parse(
                            personels[position].dateOfBirth.toString())))
                        .toString() +
                    "\n" +
                    personels[position].job +
                    "\n" +
                    personels[position].eMail +
                    "\n" +
                    personels[position].gender +
                    "\n"
                //\n alt satır  için
                ),
            subtitle: Text(
                personels[position].description), //alt başlık ta açıklaması
            onTap: () {},
          ),
        );
      });
}
