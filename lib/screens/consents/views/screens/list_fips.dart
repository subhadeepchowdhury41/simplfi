import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/finvu/consent_model.dart';
import 'package:simplfi/providers/auth_provider.dart';
import 'package:simplfi/screens/consents/repo/consents_repo.dart';
import 'package:simplfi/screens/consents/views/screens/consent_approve.dart';
import 'package:simplfi/services/finvu/repo/finvu_repo.dart';
import 'package:uuid/uuid.dart';

class ListFipScreen extends ConsumerStatefulWidget {
  const ListFipScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListFipScreenState();
}

class _ListFipScreenState extends ConsumerState<ListFipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                'Choose the bank',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 34),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Text(
                'you want to link',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 23),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
        Expanded(
            child: FutureBuilder(
          future: FinVuRepo.getAllFIPs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.95,
                      crossAxisCount: 3),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async {
                      final sessionId = const Uuid().v1();
                      const redirectUrl =
                          'https://simplfi.app/redirect/8768715527@finvu';
                      await FinVuRepo.sendConsentRequest(
                              userSessionId: sessionId,
                              redirectUrl: redirectUrl,
                              email: ref.read(authProvider)!.email!)
                          .then((encryptedConsent) async {
                        if (encryptedConsent == null) {
                          return;
                        }

                        await ConsentsRepo.addConsent(
                                ref.read(authProvider)!.uid!,
                                Consent(encryptedConsent: encryptedConsent))
                            .then((value) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ConsentApprovalScreen(
                                        phone: '',
                                        redirectUrl: redirectUrl,
                                        fipId: snapshot.data![index].fipId,
                                        encryptedConsent: encryptedConsent,
                                      )));
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.fromBorderSide(
                              BorderSide(width: 1, color: Colors.blue[300]!))),
                      margin: const EdgeInsets.all(9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Image.network(snapshot
                                      .data?[index].entityLogoUri ??
                                  'https://finvu.in/cdn/finvu_bank_icon.png'),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: Text(
                                    snapshot.data![index].fipId,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Column(
                  children: [Center(child: Text('Something went wrong!'))],
                );
              }
            }
          },
        ))
      ],
    ));
  }
}
