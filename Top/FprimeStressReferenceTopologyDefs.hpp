// ======================================================================
// \title  FprimeStressReferenceTopologyDefs.hpp
// \brief  Required header for the topology autocoder. Pulls in every
//         subtopology PingEntries / TopologyDefs file and declares the
//         per-instance health-ping thresholds used by the deployment.
// ======================================================================
#ifndef FprimeStressReference_FprimeStressReferenceTopologyDefs_HPP
#define FprimeStressReference_FprimeStressReferenceTopologyDefs_HPP

#include "Top/FppConstantsAc.hpp"

// Subtopology PingEntries includes
#include "Svc/Subtopologies/CdhCore/PingEntries.hpp"
#include "Svc/Subtopologies/ComCcsds/PingEntries.hpp"
#include "Svc/Subtopologies/FileHandling/PingEntries.hpp"
#include "DoomSubtopology/PingEntries.hpp"

// SubtopologyTopologyDefs includes
#include "Svc/Subtopologies/CdhCore/SubtopologyTopologyDefs.hpp"
#include "Svc/Subtopologies/ComCcsds/SubtopologyTopologyDefs.hpp"
#include "Svc/Subtopologies/FileHandling/SubtopologyTopologyDefs.hpp"
#include "DoomSubtopology/SubtopologyTopologyDefs.hpp"

// FPP constants from each subtopology config. Required because the
// outer topology autocoder inlines each subtopology's
// `phase configComponents` body into the deployment-level
// FprimeStressReferenceTopologyAc.cpp, where those config namespaces
// must already be visible.
#include "Svc/Subtopologies/CdhCore/CdhCoreConfig/FppConstantsAc.hpp"
#include "Svc/Subtopologies/ComCcsds/ComCcsdsConfig/FppConstantsAc.hpp"
#include "Svc/Subtopologies/FileHandling/FileHandlingConfig/FppConstantsAc.hpp"
#include "DoomSubtopology/DoomSubtopologyConfig/FppConstantsAc.hpp"

// Per-instance health-ping thresholds. The local active components in
// the deployment (rate groups and the command sequencer) need their
// PingEntries::<module>_<inst> stub declared so the topology autocoder
// can resolve them.
namespace PingEntries {
namespace FprimeStressReference_rateGroup1Comp {
enum { WARN = 3, FATAL = 5 };
}
namespace FprimeStressReference_rateGroup2Comp {
enum { WARN = 3, FATAL = 5 };
}
namespace FprimeStressReference_rateGroup3Comp {
enum { WARN = 3, FATAL = 5 };
}
namespace FprimeStressReference_cmdSeq {
enum { WARN = 3, FATAL = 5 };
}
}  // namespace PingEntries

namespace FprimeStressReference {

//! Topology setup state. Wraps all the per-subtopology state pieces
//! plus the deployment-specific knobs (TCP comm and WAD path).
struct TopologyState {
    const char* hostname;
    U16 port;
    //! Path to the DOOM IWAD file that should be passed to the engine.
    //! Empty string means "let DOOM auto-search".
    const char* wadPath;
    //! True if the engine should auto-start at topology setup time;
    //! false if the operator will dispatch the Start command manually.
    bool autoStart;
    CdhCore::SubtopologyState cdhCore;
    ComCcsds::SubtopologyState comCcsds;
    FileHandling::SubtopologyState fileHandling;
    DoomSubtopology::SubtopologyState doom;
};

namespace PingEntries = ::PingEntries;

}  // namespace FprimeStressReference

#endif
