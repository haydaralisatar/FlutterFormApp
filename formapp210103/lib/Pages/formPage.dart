//Kütüphanelerimi dahil ettik
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:formapp210103/Models/Personel.dart'; //Diğer dart dosyalarımız
import 'package:formapp210103/Pages/personelList.dart';

class FormPage extends StatefulWidget {
  //Statefullwidget kullandık sabit olmadıgı için
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  //DEğişkenlerimizi tanımladık

  bool radioState =
      true; //radiobutton erkek mi kadın mı oldugunu belirlemek için
  String gender = ""; //cinsiyet değişkeni
  DateTime dateOf; //doğum tarihi
  String selectedJobs =
      "Bilgisayar Mühendisi"; //Seçili olan değere default değer verdik.
  List<String> jobs = [
    'Bilgisayar Mühendisi',
    'Yazılım Mühendisi',
    '"Bilgisayar Programcısı"',
    'Donanım Mühendisi',
    "İç Mimar"
  ];
  //Dropdown içindeki değerleri tanımladık.
  final _formKey = GlobalKey<FormState>(); //form nesnesi türettik.
  TextEditingController nameSurname =
      new TextEditingController(); //Formdaki değerlerin controllerını belirledik.
  TextEditingController dateOfBirth =
      new TextEditingController(); //Formdaki değerlerin controllerını belirledik.
  TextEditingController phone =
      new TextEditingController(); //Formdaki değerlerin controllerını belirledik.
  TextEditingController eMail =
      new TextEditingController(); //Formdaki değerlerin controllerını belirledik.
  TextEditingController description =
      new TextEditingController(); //Formdaki değerlerin controllerını belirledik.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //pxel hatasını önlemek için
      appBar: AppBar(
        //Programın üst kısmı
        title: Text("Personel Form App"), //Tittle ı
      ),
      body: Container(
        padding: new EdgeInsets.symmetric(
          //Kenarlardan boşluk verdik.
          vertical: 50.0,
          horizontal: 10.0,
        ),
        child: Column(
          //Kolon oluşturduk.
          children: <Widget>[
            _buildForm(), //formumuzu çağırdık
          ],
        ),
      ),
      floatingActionButton: Row(
          //butonları oluşturduk.
          //  Sağdan-Sola Hizalama
          mainAxisAlignment:
              MainAxisAlignment.end, //sağdan başlamasını sağladık
          //  Yukarıdan-Aşağıya Hizalama
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                //tıklandığında
                _formKey.currentState.reset(); //formu resetledi.
                setState(() {
                  gender = "Male"; //ayarlar default haline döndü
                  radioState = true; //ayarlar default haline döndü
                  selectedJobs =
                      "Bilgisayar Mühendisi"; //ayarlar default haline döndü
                  dateOfBirth.text = ""; //ayarlar default haline döndü
                });
              },
              child: Icon(Icons.clear), //İconu X işareti oldu
            ),
            SizedBox(
              // iki buton arası mesafeyi ayarladık.
              width: 10,
            ),
            FloatingActionButton(
              heroTag:
                  1, //iki sayfa arasında geçiş yaparken siyah ekran hatası çözümü
              onPressed: () {
                //tıklandığında
                if (_formKey.currentState.validate()) {
                  //formu kontrol ediyor boş alan yoksa
                  Personel person =
                      new Personel(); // personel nesnesi türettik.
                  person.nameSurname = nameSurname
                      .text; //Personeldeki name 'e nameSurname CONTROLLER ındak texti attık.
                  person.gender =
                      gender; //Personeldeki gender 'e gender CONTROLLER ındak texti attık.
                  person.dateOfBirth =
                      dateOf; //Personeldeki dateOfBirth 'e dateOf CONTROLLER ındak texti attık.
                  person.eMail = eMail
                      .text; //Personeldeki eMail 'e eMail CONTROLLER ındak texti attık.
                  person.phone = phone
                      .text; //Personeldeki phone 'e phone CONTROLLER ındak texti attık.
                  person.description = description
                      .text; //personeldeki description 'e description CONTROLLER ındak texti attık.
                  person.job =
                      selectedJobs; //Personeldeki job 'e selectedJobs CONTROLLER ındak texti attık.
                  db.addPerson(person); //Listemize ekledik.
                  _formKey.currentState.save(); //kaydettik.
                  Navigator.push(
                      context, //Personelist sayfasınına yönlendirdik.
                      MaterialPageRoute(builder: (context) => PersoneList()));
                }
              },
              child: Icon(Icons.done), //Iconu tik olarak belirledik.
            ),
          ]),
    );
  }

  Form _buildForm() {
    //Form widgetımızı oluştrduk.
    var date = DateTime.now(); //şu anın tarihini date değişkenine attık.
    return Form(
      //Form geri döndürdük.
      key: _formKey, //yukarıda türettiğimiz formkey
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.all(7.0), //Sayfanın her yerinden padding verdik.
            child: TextFormField(
              //Text alanı oluşturduk.
              controller: nameSurname,
              validator: (String value) {
                //eğer boşsa
                if (value.isEmpty) {
                  //hata mesajı verdirdik.
                  return "Name is required";
                } else
                  return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), //ıcon
                labelText: 'Full Name', //Boşkan yazan yazı
                border: OutlineInputBorder(
                    //kenarlık
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //2 tane radio button oluşturduk.
              Flexible(
                flex: 1,
                child: RadioListTile(
                  title: Text("Male"), //Erkek olan button
                  value: true, //DEğeri true
                  groupValue: radioState,
                  onChanged: (state) {
                    setState(() {
                      radioState = state;
                      gender =
                          "Male"; //listeye eklerken kullanacaığımız değişkene değeri attık.
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: RadioListTile(
                  title: Text("Female"),
                  value: false, //DEğeri false
                  groupValue: radioState,
                  onChanged: (state) {
                    setState(() {
                      radioState = state;
                      gender =
                          "Female"; //listeye eklerken kullanacaığımız değişkene değeri attık.
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: TextFormField(
              controller: dateOfBirth, //Doğum tarihi alanı
              onTap: () {
                //tıklandıgında
                showDatePicker(
                        //date picler açılıcak
                        context: context,
                        initialDate: date, //şuanki tarihi göstericek
                        firstDate: DateTime(2000), //aralık
                        lastDate: DateTime(2026),
                        fieldLabelText: "Booking Date",
                        fieldHintText: "Month/Date/Year")
                    .then((value) {
                  //sonra seçilen değeri
                  dateOfBirth.text = (DateFormat("dd/MM/yyyy")
                          .format(DateTime.parse(value.toString())))
                      .toString(); //o texte yazıcak burdaki değer text
                  dateOf =
                      value; //listeye eklerken kullanacağımız değer burdaki değer date
                });
              },
              validator: (String value) {
                //boşsa
                if (value.isEmpty) {
                  return "Date is required"; //hata mesajı
                } else
                  return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                labelText:
                    'Date of Birth', //kenarlıklar ve içi boşşsa yazılacak yazı
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 0.50,
                  ),
                ),
                child: DropdownButton<String>(
                  //Meslek seçimi
                  icon: Icon(Icons.eject), //İcon belirttik.
                  hint: Text("Select job"), //boşken çıkacak olan yazı
                  items: jobs.map((job) {
                    //içinde olacak değerleri belirttik.
                    return DropdownMenuItem<String>(
                      child: Text(job),
                      value: job,
                    );
                  }).toList(),
                  onChanged: (data) {
                    //seçildiğinde
                    setState(() {
                      selectedJobs = data; //seçilenMeslek alanını değiştridik.
                    });
                  },
                  value: selectedJobs,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: TextFormField(
              controller: phone,
              validator: (String value) {
                //Eğer boşsa
                if (value.isEmpty) {
                  //Hata mesajı
                  return "Phone is required";
                } else
                  return null;
              },
              keyboardType:
                  TextInputType.phone, //Klavyeden numaralar kısmı açıldı
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone), //Icon belirttik.
                labelText: 'Phone', //Boşken olan yazı
                border: OutlineInputBorder(
                    //Kenarlıklar
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: TextFormField(
              //Email kısmı
              controller: eMail,
              validator: (String value) {
                //Boşsa
                if (value.isEmpty) {
                  //Hata mesajı
                  return "Email is required";
                } else
                  null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email), //Icon belirttik.
                labelText: 'E-Mail', //boşken olan yazı
                border: OutlineInputBorder(
                    //Kenarlıklar
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: TextFormField(
              maxLines: null, //birden fazla satır.
              controller: description, //Açıklama alanı
              validator: (String value) {
                //Boşsa
                if (value.isEmpty) {
                  //Hata mesajı
                  return "Description is required";
                } else
                  null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.description), //Icon belirttik.
                labelText: 'Description', //boşken olan yazı
                border: OutlineInputBorder(
                    //Kenarlıklar
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
