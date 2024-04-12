import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../custom_appbar.dart';
import '../../custom_container.dart';
import '../../custom_textfield.dart';
import '../../custom_textstyles.dart';
import '../../gen/colors.gen.dart';
import '../../services/database.dart';
import '../../strings.dart';
import '../home_screen.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final formKey = GlobalKey<FormState>();
  bool autoValidateMode = false;
  final companyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.customAppBar(context,
          appBarTitle: Strings.company,
          onTapArrow: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const HomeScreen()));
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode ?
            AutovalidateMode.onUserInteraction :
            AutovalidateMode.disabled,
            child: Column(
              children: [
                CustomTextField.customTextField(
                  controller: companyNameController,
                  keyboardType: TextInputType.name,
                  context,
                  hintText: Strings.companyName,
                  labelText: Strings.companyName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.enterCompanyName;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomContainer.customContainer(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.08,
                    context,
                    text: Strings.add,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        String id=FirebaseFirestore.instance.collection('Company').doc().id;
                        var company = {
                          "company_name": companyNameController.text,
                         "id" : id,
                        };
                        await Database.addCompany(company,id).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Add Company Success")));
                        }
                        );
                        FocusManager.instance.primaryFocus?.unfocus();
                        companyNameController.clear();
                        formKey.currentState!.reset();
                      }
                      else {
                        setState(() {
                          autoValidateMode = true;
                        });
                      }
                    }
                ),
                const SizedBox(height:20),
                StreamBuilder(
                  stream: Database.getAllCompany(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(
                    child:Center(child:CircularProgressIndicator()));
                    }else if(snapshot.hasError){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.error.toString())));
                    }
                   else if(snapshot.hasData){
                      if(snapshot.data!=null && snapshot.data!.docs.isNotEmpty){
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Strings.listOfCompanies,
                                    style:CustomTextStyles.textStyle14(context).copyWith(
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height:10),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var docs=snapshot.data!.docs[index];
                                    return Padding(
                                      padding: EdgeInsets.only(top:index==0 ? 0 : 10),
                                      child: CustomContainer.customContainer(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.08,
                                          context,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:10,right:10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(docs["company_name"],style: CustomTextStyles.textStyle20(context)),
                                                GestureDetector(
                                                    onTap: () async {
                                                      await Database.deleteCompany(docs["id"]);
                                                    },
                                                    child: const Icon(Icons.delete,color:ColorName.whiteColor)),
                                              ],
                                            ),
                                          )
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }
                    return const Center(
                    child:Center(child:Text("No Data"))
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
